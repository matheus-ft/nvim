vim.opt.signcolumn = 'yes' -- kinda weird this is not a boolean for neovim, but okay

require('gitsigns').setup({
  signs = {
    add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  },
  numhl = true,

  current_line_blame = true,
  current_line_blame_opts = {
    delay = 0,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '  <author>, <author_time:%Y-%m-%d> - <summary>',

  update_debounce = 100,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
})

local noremap = require('matheus').noremap
noremap('n', 'zi', '<cmd>Gitsigns preview_hunk<CR>', 'Preview git diff')
noremap('n', 'zd', '<cmd>Gitsigns diffthis<CR>', 'Open git diff buffer')
noremap('n', 'zj', '<cmd>Gitsigns next_hunk<CR>', 'Next git hunk')
noremap('n', 'zk', '<cmd>Gitsigns prev_hunk<CR>', 'Previous git hunk')
