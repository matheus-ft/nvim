M = require('lspsaga')

M.init_lsp_saga({
  --- Keybindings ---
  move_in_saga = { prev = '<C-p>', next = '<C-n>' }, -- when cursor in saga window you config these to move
  finder_action_keys = { -- apparently, tables work here...
    open = { 'o', '<CR>' },
    vsplit = { 'v', 'y' },
    split = { 's', 'x' },
    tabe = { 't', 'i', 'b' },
    quit = { 'q', '<ESC>' },
  },
  code_action_keys = { -- ... but not here...
    exec = '<CR>',
    quit = 'q',
  },
  definition_action_keys = { -- ... NOR HERE...
    edit = 'ge', -- go edit
    split = 'gs', -- go in split
    vsplit = 'gv', -- go in vertical split
    tabe = 'gb', -- go to buftab
    quit = 'q',
  },
  rename_action_quit = { '<C-c>', '<Esc><Esc>', '<Esc>q' }, -- ... BUT WORKS HERE, WTF

  --- Look and feel ---
  border_style = 'single', -- 'single' | 'double' | 'rounded' | 'bold' | 'plus'
  saga_winblend = 0, -- transparecy between 0-100 (no need for extra imo)
  -- Error, Warn, Info, Hint
  -- use emoji like
  -- { '🙀', '😿', '😾', '😺' }
  -- or
  -- { '😡', '😥', '😤', '😐' }
  -- and diagnostic_header can be a function type
  -- must return a string and when diagnostic_header
  -- is function type it will have a param `entry`
  -- entry is a table type has these filed
  -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
  diagnostic_header = { ' ', ' ', ' ', 'ﴞ ' },
  preview_lines_above = 0, -- preview lines above of lsp_finder
  max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  code_action_icon = '💡', -- use emoji lightbulb in default
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
  rename_in_select = true,
  symbol_in_winbar = { -- show symbols in winbar must nightly
    in_custom = false, -- mean use lspsaga api to get symbols and set it to your custom winbar or some winbar plugins.
    enable = true, -- if in_custom = true you must set enable to false
    separator = '  ',
    show_file = true,
    -- define how to customize filename, eg: %:., %
    -- more information see `vim.fn.expand` or `expand`
    file_formatter = '%:t', -- default
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
})

return M
