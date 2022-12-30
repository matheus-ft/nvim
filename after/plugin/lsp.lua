local noremap = require('matheus').noremap

---------------------------------------------------------------------------------------
-- Autocompletion, snippets and autogen-docs
---------------------------------------------------------------------------------------
local cmp = require('cmp')
local lspkind = require('matheus.lsp.kind')

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

vim.opt.completeopt:append({ 'menu', 'menuone', 'noselect' })

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
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- default vim behavior
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- default vim behavior
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }), -- accept the explicitly selected item
    ['<C-Space>'] = cmp.mapping.complete({ behavior = cmp.SelectBehavior.Insert }), -- this does not work rn :/
    ['<C-y>'] = cmp.mapping( -- borrowed from Teej
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { 'i', 'c' }
    ),
    ['<C-e>'] = cmp.mapping.abort(),
  },

  sources = { -- in order of priority
    { name = 'nvim_lua' }, -- only works for lua, so won't fuck up the priority
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 3 },
  },

  snippet = { -- to get snippets enabled
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require('cmp-under-comparator').under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', lspkind[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[LaTeX]',
      })[entry.source.name]
      return vim_item
    end,
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
local extra = require('matheus.lsp.extra')
local preview = extra.preview
local todo = extra.todo
local ok, wk = pcall(require, 'which-key')
require('matheus.lsp.formatter')
require('matheus.lsp.saga')
require('matheus.lsp.signature')
require('matheus.lsp.utils')

local on_attach = function(client, bufnr)
  illuminate.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>

  -- Mappings
  local lsp = vim.lsp.buf
  local bufopts = { silent = true, buffer = bufnr }

  noremap('n', '<A-n>', function()
    illuminate.next_reference({ wrap = true })
  end, 'Jump to next occurance', bufopts)
  noremap('n', '<A-N>', function()
    illuminate.next_reference({ reverse = true, wrap = true })
  end, 'Jump to previous occurance', bufopts)

  noremap('n', 'gD', lsp.declaration, 'Go to declaration', bufopts)
  noremap('n', 'gd', lsp.definition, 'Go to definition', bufopts)
  noremap('n', 'gpd', '<cmd>Lspsaga peek_definition<CR>', 'Preview definition', bufopts)

  noremap('n', 'gt', lsp.type_definition, 'Go to type-definition', bufopts)
  noremap('n', 'gpt', preview.goto_preview_type_definition, 'Preview type-def', bufopts)

  noremap('n', 'gi', lsp.implementation, 'Go to implementation', bufopts)
  noremap('n', 'gpi', preview.goto_preview_implementation, 'Preview implementation', bufopts)

  noremap('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', 'Go to references', bufopts)
  noremap('n', 'gr', lsp.references, 'Open references', bufopts)
  noremap('n', 'gpr', preview.goto_preview_references, 'Preview references in Telescope', bufopts)

  if ok then
    wk.register({ ['gp'] = 'Go to preview' }, { mode = 'n' })
  end
  noremap('n', 'go', '<cmd>Lspsaga lsp_finder<CR>', 'Find all occurances', bufopts)

  noremap('n', 'K', lsp.hover, 'Hover docs', bufopts)
  noremap('n', '<leader>f', vim.cmd.FormatLock, 'Format file', bufopts)
  noremap('n', '<leader>r', '<cmd>Lspsaga rename<CR>', 'Rename symbol', bufopts)
  noremap({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Code actions', bufopts)

  if ok then
    wk.register({ ['<leader>e'] = 'Diagnostics' }, { mode = 'n' })
  end
  noremap('n', '<leader>el', '<cmd>TroubleToggle<cr>', 'List diagnostics', bufopts)
  noremap('n', '<leader>ew', '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace diagnostics', bufopts)
  noremap('n', '<leader>ef', '<cmd>TroubleToggle document_diagnostics<cr>', 'File diagnostics', bufopts)
  noremap('n', '<leader>et', '<cmd>TodoTrouble<cr>', 'TODOs', bufopts)

  noremap('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic', bufopts)
  noremap('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic', bufopts)
  noremap('n', ']t', todo.jump_next, 'Next todo comment', bufopts)
  noremap('n', '[t', todo.jump_prev, 'Previous todo comment', bufopts)
end

noremap('n', '<A-i>', '<cmd>Lspsaga open_floaterm<CR>', 'Open floating terminal')
-- if you want pass somc cli command into terminal you can put before <CR>
noremap('t', '<A-i>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], 'Close floating terminal')

---------------------------------------------------------------------------------------
-- Languages settings
---------------------------------------------------------------------------------------
local servers = { 'bashls', 'pyright', 'marksman' } -- Lua is set later

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

-- got below from https://github.com/neovim/nvim-lspconfig/issues/319#issuecomment-1236123717
local start_sumneko_lua = true
local current_buf_id = vim.api.nvim_get_current_buf()
local servers_attached_to_current_buf = vim.lsp.get_active_clients({ bufnr = current_buf_id })

for _, server in ipairs(servers_attached_to_current_buf) do
  if server.name == 'sumneko_lua' then -- an instance of sumneko_lua is already attached to the buffer
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
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })
end
