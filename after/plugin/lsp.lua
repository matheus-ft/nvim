local noremap = require('matheus').noremap

---------------------------------------------------------------------------------------
-- Autocompletion, snippets and autogen-docs
---------------------------------------------------------------------------------------
local cmp = require('cmp')

noremap('n', '<leader>d', '<Plug>(doge-generate)', 'Insert documentation')
vim.g.doge_comment_jump_modes = { 'n', 's' } -- removing i to use tab-completion
vim.g.doge_doc_standard_python = 'numpy'

-- borrowed from NvChad
local function border(hl_name)
  return {
    { '╭', hl_name },
    { '─', hl_name },
    { '╮', hl_name },
    { '│', hl_name },
    { '╯', hl_name },
    { '─', hl_name },
    { '╰', hl_name },
    { '│', hl_name },
  }
end

vim.opt.completeopt:append { 'menu', 'menuone', 'noselect' }

-- If you want insert `(` after select function or method item
local autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', autopairs.on_confirm_done())

cmp.setup({
  window = {
    completion = {
      border = border('CmpBorder'),
      winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    },
    documentation = {
      border = border('CmpDocBorder'),
    },
  },

  mapping = {
    ['<C-n>']     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- default vim behavior
    ['<C-p>']     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- default vim behavior
    ['<Tab>']     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>']   = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>']      = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }), -- accept the explicitly selected item
    ['<C-Space>'] = cmp.mapping.complete({ behavior = cmp.SelectBehavior.Insert }),

    ['<c-y>'] = cmp.mapping(-- borrowed from Teej
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { 'i', 'c' }
    ),

    ['<c-e>'] = cmp.mapping.abort(),
    ['<c-u>'] = cmp.mapping.scroll_docs(-4),
    ['<c-d>'] = cmp.mapping.scroll_docs(4),
  },

  -- sources of autocompletion (in order of priority)
  sources = {
    { name = 'nvim_lua' }, -- only works for lua, so won't fuck up the priority
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 3 },
  },

  -- to get snippets enabled
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

require('luasnip.loaders.from_vscode').lazy_load() -- funny, huh?

-- Set configuration for specific filetype
-- cmp.setup.filetype()

-- integration with LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

---------------------------------------------------------------------------------------
-- LSP general configs
---------------------------------------------------------------------------------------
local lspconfig = require('lspconfig')
local illuminate = require('illuminate')
local preview = require('goto-preview')
local saga = require('matheus.lsp.saga')
local extra = require('matheus.lsp.extra')
require('matheus.lsp.signature')
require('matheus.lsp.utils')

preview.setup()
local todo = extra.todo
local ok, wk = pcall(require, 'which-key')

local on_attach = function(client, bufnr)
  illuminate.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>

  -- Mappings
  local lsp = vim.lsp.buf
  local bufopts = { silent = true, buffer = bufnr }
  local preview_opts = { dismiss_on_move = true }
  noremap('n', '<A-n>', function() illuminate.next_reference({ wrap = true }) end, 'Jump to next occurance', bufopts)
  noremap('n', '<A-N>',
    function() illuminate.next_reference({ reverse = true, wrap = true }) end,
    'Jump to previous occurance', bufopts)
  noremap('n', '<S-k>', lsp.hover, 'Hover docs', bufopts)
  noremap('i', '<A><S-k>', lsp.signature_help, 'Open function signature help', bufopts)

  noremap('n', 'gd', lsp.definition, 'Go to definition', bufopts)
  noremap('n', 'gpd', '<cmd>Lspsaga peek_definition<CR>', 'Preview definition', bufopts)
  noremap('n', 'gD', lsp.declaration, 'Go to declaration', bufopts)

  noremap('n', 'gt', lsp.type_definition, 'Go to type-definition', bufopts)
  noremap('n', 'gpt', function() preview.goto_preview_type_definition(preview_opts) end, 'Preview type-def', bufopts)

  noremap('n', 'gi', lsp.implementation, 'Go to implementation', bufopts)
  noremap('n', 'gpi', function() preview.goto_preview_implementation(preview_opts) end, 'Preview implementation', bufopts)

  noremap('n', 'gr', lsp.references, 'Open references', bufopts)
  noremap('n', 'gpr', function() preview.goto_preview_references() end, 'Preview references in Telescope', bufopts)
  noremap('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', 'Go to references', bufopts)

  if ok then wk.register({ ['gp'] = 'Go to preview' }, { mode = 'n' }) end
  noremap('n', 'go', '<cmd>Lspsaga lsp_finder<CR>', 'Find all occurances', bufopts)

  noremap('n', '<leader>f', function() lsp.format({ async = true }) end, 'Format file', bufopts)
  noremap('n', '<leader>r', '<cmd>Lspsaga rename<CR>', 'Rename symbol', bufopts)
  noremap({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Code actions', bufopts)

  if ok then wk.register({ ['<leader>e'] = 'Diagnostics' }, { mode = 'n' }) end
  local error = vim.diagnostic.severity.ERROR
  noremap('n', '<leader>en', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic', bufopts)
  noremap('n', '<leader>ep', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous diagnostic', bufopts)
  noremap('n', '<leader>eN', function() saga.diagnostic.goto_next({ severity = error }) end, 'Next error', bufopts)
  noremap('n', '<leader>eP', function() saga.diagnostic.goto_prev({ severity = error }) end, 'Previous error', bufopts)
  noremap('n', '<leader>el', '<cmd>TroubleToggle<cr>', 'List in Trouble', bufopts)
  noremap('n', '<leader>ew', '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace diagnostics', bufopts)
  noremap('n', '<leader>ef', '<cmd>TroubleToggle document_diagnostics<cr>', 'File diagnostics', bufopts)
  noremap('n', '<leader>ett', '<cmd>TodoTrouble<cr>', 'Toggle TODOs', bufopts)
  noremap('n', '<leader>etn', function() todo.jump_next() end, 'Next todo comment', bufopts)
  noremap('n', '<leader>etp', function() todo.jump_prev() end, 'Previous todo comment', bufopts)
  if ok then wk.register({ ['<leader>dt'] = 'TODO comments' }, { mode = 'n' }) end
end


local opts = { silent = true }

noremap('n', '<A-i>', '<cmd>Lspsaga open_floaterm<CR>', 'Open floating terminal', opts)
-- if you want pass somc cli command into terminal you can put before <CR>
noremap('t', '<A-i>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], 'Close floating terminal', opts)

---------------------------------------------------------------------------------------
-- Languages settings
---------------------------------------------------------------------------------------
local servers = { 'bashls', 'pyright', 'marksman', 'diagnosticls' } -- Lua LS set later

-- this have to be done before any servers are set up
require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_installtion = true,
})

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- little hack to have personalized formatting
lspconfig['diagnosticls'].setup({
  filetypes = { 'python' },
  init_options = {
    formatters = {
      black = { command = 'black', args = { '-' } },
      docformatter = { command = 'docformatter', args = { '-' } },
    },
    formatFiletypes = {
      python = { 'black', 'docformatter' } -- pyright does not have its own formatter
    }
  }
})

-- got below from https://github.com/neovim/nvim-lspconfig/issues/319#issuecomment-1236123717
local start_sumneko_lua = true
local current_buf_id = vim.api.nvim_get_current_buf()
local servers_attached_to_current_buf = vim.lsp.get_active_clients({ bufnr = current_buf_id })

for _, server in ipairs(servers_attached_to_current_buf) do
  if server.name == "sumneko_lua" then --an instance of sumneko_lua is already attached to the buffer
    start_sumneko_lua = false
  end
end

if start_sumneko_lua then
  -- borrowed below from NvChad
  lspconfig['sumneko_lua'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })
end
