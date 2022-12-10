local keymap = vim.keymap.set
local cmp = require('cmp')
local lspconfig = require("lspconfig")
local saga = require('lspsaga')

---------------------------------------------------------------------------------------
-- Autocompletion with nvim-cmp
---------------------------------------------------------------------------------------
vim.opt.completeopt:append { 'menu', 'menuone', 'noselect' }

-- borrowed from NvChad
local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

cmp.setup({
  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border "CmpDocBorder",
    },
  },

  mapping = {
    ["<C-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- default vim behavior
    ["<C-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- default vim behavior
    ["<Tab>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<S-Tab>"]   = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>']      = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }), -- accept the explicitly selected item
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<c-y>"] = cmp.mapping(-- borrowed from Teej
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    ["<c-e>"] = cmp.mapping.abort(),
    ["<c-u>"] = cmp.mapping.scroll_docs(-4),
    ["<c-d>"] = cmp.mapping.scroll_docs(4),
  },

  -- sources of autocompletion (in order of priority)
  sources = {
    { name = 'nvim_lua' }, -- only works for lua
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

require("luasnip.loaders.from_vscode").lazy_load() -- funny, huh?

-- Set configuration for specific filetype
-- cmp.setup.filetype()

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
  keymap('n', '<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', bufopts)
  keymap('n', '<A-N>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', bufopts)
  keymap('n', '<S-k>', vim.lsp.buf.hover, bufopts)
  keymap('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
  keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
  keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  keymap('n', 'gr', vim.lsp.buf.references, bufopts)
  keymap('n', '<leader>f', vim.lsp.buf.format, bufopts)
  -- keymap('n', '<A-k>', vim.lsp.buf.signature_help, bufopts) -- never works
end

local opts = { noremap = true, silent = true }

-- keymap("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)
-- keymap("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
keymap("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts) -- Only set if you have telescope installed
keymap("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts)
keymap("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", opts)
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts) -- use <C-t> to jump back

keymap("n", "<leader>r", "<cmd>Lspsaga rename<CR>", opts)
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

keymap("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "<leader>Nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
-- Only jump to error
keymap("n", "<leader>ne",
  function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, opts)
keymap("n", "<leader>Ne",
  function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, opts)

keymap("n", "<leader>out", "<cmd>LSoutlineToggle<CR>", opts) -- functions on the right hand side

keymap("n", "<A-i>", "<cmd>Lspsaga open_floaterm<CR>", opts) -- if you want pass somc cli command into terminal you can put before <CR>
keymap("t", "<A-i>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)

require('matheus.lsputils')

saga.init_lsp_saga {
  border_style = "single", -- "single" | "double" | "rounded" | "bold" | "plus"
  saga_winblend = 0, -- transparecy between 0-100 (no need for extra imo)
  move_in_saga = { prev = '<C-p>', next = '<C-n>' }, -- when cursor in saga window you config these to move
  -- Error, Warn, Info, Hint
  -- use emoji like
  -- { "🙀", "😿", "😾", "😺" }
  -- or
  -- { "😡", "😥", "😤", "😐" }
  -- and diagnostic_header can be a function type
  -- must return a string and when diagnostic_header
  -- is function type it will have a param `entry`
  -- entry is a table type has these filed
  -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
  diagnostic_header = { " ", " ", " ", "ﴞ " },
  preview_lines_above = 0, -- preview lines above of lsp_finder
  max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  code_action_icon = "💡", -- use emoji lightbulb in default
  code_action_num_shortcut = true, -- if true can press number to execute the codeaction in codeaction window
  code_action_lightbulb = { -- same as nvim-lightbulb but async
    enable = true,
    enable_in_insert = true,
    cache_code_action = true,
    sign = true,
    update_time = 150,
    sign_priority = 20,
    virtual_text = true,
  },
  finder_icons = { -- finder icons
    def = '  ',
    ref = '諭 ',
    link = '  ',
  },
  finder_request_timeout = 1500, -- finder do lsp request timeout -- if your project big enough or your server very slow you may need to increase this value
  finder_action_keys = {
    open = { 'o', '<CR>' },
    vsplit = { 'v', 'y' },
    split = { 's', 'x' },
    tabe = { 't', 'i' },
    quit = { 'q', '<ESC>' },
  },
  code_action_keys = {
    exec = '<CR>',
    quit = { 'q', '<Esc>' },
  },
  definition_action_keys = {
    edit = { '<C-c>o', '<C-w>' },
    vsplit = { '<C-c>v', '<C-c>y' },
    split = { '<C-c>s', '<C-c>x' },
    tabe = { '<C-c>t', '<C-c>i' },
    quit = 'q',
  },
  rename_action_quit = '<C-c>',
  rename_in_select = true,
  symbol_in_winbar = { -- show symbols in winbar must nightly
    in_custom = false, -- mean use lspsaga api to get symbols and set it to your custom winbar or some winbar plugins.
    enable = true, -- if in_custom = true you must set enable to false
    separator = ' ',
    show_file = true,
    -- define how to customize filename, eg: %:., %
    -- if not set, use default value `%:t`
    -- more information see `vim.fn.expand` or `expand`
    -- ## only valid after set `show_file = true`
    file_formatter = "",
    click_support = false,
  },
  show_outline = {
    win_position = 'right',
    --set special filetype win that outline window split.like NvimTree neotree
    -- defx, db_ui
    win_with = '',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = 'o',
    -- auto refresh when change buffer
    auto_refresh = true,
  },
  custom_kind = {}, -- custom lsp kind -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
  server_filetype_map = {}, -- if you don't use nvim-lspconfig you must pass your server name and the related filetypes into this table
}

---------------------------------------------------------------------------------------
-- Languages settings
---------------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'bash', 'python', "markdown" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
})

local servers = { 'sumneko_lua', 'bashls', 'pyright', 'marksman' }

-- this have to be set up before any servers are set
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installtion = true,
})

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- borrowed from NvChad
lspconfig["sumneko_lua"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- little hack to have personalized formatting
lspconfig['diagnosticls'].setup({
  filetypes = { "python" },
  init_options = {
    formatters = {
      black = { command = "black", args = { "-" } },
      docformatter = { command = "docformatter", args = { "-" } },
    },
    formatFiletypes = {
      python = { "black", "docformatter" } -- pyright does not have its own formatter
    }
  }
})
