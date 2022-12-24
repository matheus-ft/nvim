---------------------------------------------------------------------------------------
-- Autocompletion, snippets and autogen-docs
---------------------------------------------------------------------------------------
local cmp = require('cmp')

-- <leader>d generates documentation
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
cmp.event:on(
  'confirm_done',
  autopairs.on_confirm_done()
)

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
local noremap = require('matheus').noremap

local on_attach = function(client, bufnr)
  local illuminate = require('illuminate')

  illuminate.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>

  -- Mappings
  local bufopts = { silent = true, buffer = bufnr }
  noremap('n', '<A-n>', function() illuminate.next_reference({ wrap = true }) end, 'Jump to next occurance', bufopts)
  noremap('n', '<A-N>',
    function() illuminate.next_reference({ reverse = true, wrap = true }) end,
    'Jump to previous occurance', bufopts)
  noremap('n', '<S-k>', vim.lsp.buf.hover, 'Hover docs', bufopts)
  noremap('n', 'gt', vim.lsp.buf.type_definition, 'Go to type-definition', bufopts)
  noremap('n', 'gd', vim.lsp.buf.definition, 'Go to definition', bufopts)
  noremap('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration', bufopts)
  noremap('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation', bufopts)
  noremap('n', 'gr', vim.lsp.buf.references, 'Go to references', bufopts)
  noremap('n', '<leader>f', vim.lsp.buf.format, 'Format code', bufopts)
  noremap('i', '<A><S-k>', vim.lsp.buf.signature_help, 'Open function signature help', bufopts) -- never works
end

require('matheus.lsp.signature')
require('matheus.lsp.utils')
local saga = require('matheus.lsp.saga')
local preview = require('goto-preview')

preview.setup()
local preview_opts = { dismiss_on_move = true }
local opts = { silent = true }

noremap('n', 'gP', function() preview.close_all_win() end, 'Close all preview windows', opts)
noremap('n', 'gpt', function() preview.goto_preview_type_definition(preview_opts) end, 'Preview type-def', opts)
noremap('n', 'gpi', function() preview.goto_preview_implementation(preview_opts) end, 'Preview implementation', opts)
noremap('n', 'gpr', function() preview.goto_preview_references() end, 'Preview references', opts) -- Only set if you have telescope installed
noremap('n', 'gpd', '<cmd>Lspsaga peek_definition<CR>', 'Preview definition', opts)
noremap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', 'Find occurances', opts) -- use <C-t> to jump back

noremap('n', '<leader>r', '<cmd>Lspsaga rename<CR>', 'Refactor symbol', opts)
noremap({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Code actions', opts)

noremap('n', '<leader>nd', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic', opts)
noremap('n', '<leader>Nd', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous diagnostic', opts)
noremap('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Show line and cursor diagnostics', opts)
noremap('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', 'Show line and cursor diagnostics', opts)
-- Only jump to error
noremap('n', '<leader>ne',
  function() saga.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
  'Next error', opts)
noremap('n', '<leader>Ne',
  function() saga.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
  'Previous error', opts)

noremap('n', '<leader>out', '<cmd>Lspsaga outline<CR>', 'Show outline', opts) -- functions on the right hand side

noremap('n', '<A-i>', '<cmd>Lspsaga open_floaterm<CR>', 'Open floating terminal', opts)
noremap('t', '<A-i>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], 'Close floating terminal', opts)
-- if you want pass somc cli command into terminal you can put before <CR>

---------------------------------------------------------------------------------------
-- Languages settings
---------------------------------------------------------------------------------------
local servers = { 'sumneko_lua', 'bashls', 'pyright', 'marksman' }

-- this have to be set up before any servers are set
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

-- borrowed from NvChad
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
