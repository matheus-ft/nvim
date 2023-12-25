M = require('lspsaga')

local function Lspsaga(action)
  return vim.cmd.Lspsaga(action)
end

M.lsp = {
  rename = function()
    return Lspsaga('rename')
  end,

  preview_definition = function()
    return Lspsaga('peek_definition')
  end,

  finder = function()
    return Lspsaga('lsp_finder')
  end,

  code_action = function()
    return Lspsaga('code_action')
  end,
}

M.setup({
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
  symbol_in_winbar = {
    in_custom = false, -- mean use lspsaga api to get symbols and set it to your custom winbar or some winbar plugins.
    enable = true, -- if in_custom = true you must set enable to false
    separator = '  ',
    show_file = true,
    file_formatter = '%:t', -- more information see `vim.fn.expand` or `expand`
    click_support = true,
  },
  show_outline = {
    win_position = 'right',
    win_with = '',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = 'o',
    auto_refresh = true, -- auto refresh when change buffer
  },
})

return M
