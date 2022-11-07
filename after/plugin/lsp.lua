---------------------------------------------------------------------------------------
-- Autocompletion with nvim-cmp
---------------------------------------------------------------------------------------
vim.opt.completeopt:append { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ["<C-n>"]   = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, -- default vim behavior
    ["<C-p>"]   = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, -- default vim behavior
    ["<Tab>"]   = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<S-Tab>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<CR>']    = cmp.mapping.confirm({ select = false }), -- accept the explicitly selected item

    ["<c-y>"] = cmp.mapping(-- borrowed from Teej
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    ["<c-e>"] = cmp.mapping.abort(),
    ["<c-b>"] = cmp.mapping.scroll_docs(-4),
    ["<c-f>"] = cmp.mapping.scroll_docs(4),
  },

  -- sources of autocompletion (in order of priority)
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 3 },
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

-- Set configuration for specific filetype.
cmp.setup.filetype('lua', {
  sources = {
    { name = 'nvim_lua' },
    { name = 'buffer' },
  }
})

-- integration with LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

---------------------------------------------------------------------------------------
-- LSP general configs
---------------------------------------------------------------------------------------
local on_attach = function(client, bufnr)
  require('illuminate').on_attach(client)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', bufopts)
  vim.keymap.set('n', '<A-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', bufopts)
  vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<C><S-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<leader>nd', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<leader>Nd', vim.diagnostic.goto_prev, bufopts)
end

---------------------------------------------------------------------------------------
-- Languages settings
---------------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'bash', 'python' },
  highlight = { enable = true },
})

-- this have to be set up before any servers are set
require("mason-lspconfig").setup({
  ensure_installed = { 'sumneko_lua', 'bashls', 'pyright', 'marksman' },
  automatic_installtion = true,
})

require('lspconfig')['sumneko_lua'].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

require('lspconfig')['bashls'].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

require('lspconfig')['pyright'].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- little hack to have formatting with pyright
require('lspconfig')['diagnosticls'].setup({
  filetypes = { "python" },
  init_options = {
    formatters = {
      black = { command = "black", args = { "-" } },
      docformatter = { command = "docformatter", args = { "-" } },
    },
    formatFiletypes = {
      python = { "black", "docformatter" }
    }
  }
})

require('lspconfig')['marksman'].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

---------------------------------------------------------------------------------------
-- Snippets
---------------------------------------------------------------------------------------
require("luasnip.loaders.from_vscode").lazy_load() -- funny, huh?
