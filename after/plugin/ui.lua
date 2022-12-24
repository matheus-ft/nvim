-------------------------------------------------------------------------------
-- Colorscheme
vim.cmd [[ syntax on ]]
vim.cmd [[ filetype plugin indent on ]]

local theme = require('matheus.themes.onedark')

vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#42464e' })
vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#5b606b' })
vim.api.nvim_set_hl(0, 'IndentBlanklineContextSpaceChar', { fg = '#42464e' })
vim.api.nvim_set_hl(0, 'IndentBlanklineSpaceChar', { fg = '#42464e' })

-------------------------------------------------------------------------------
-- Indentline
vim.opt.list = true
vim.opt.listchars:append 'lead:⋅,tab:> ,trail: ' -- only shows leading spaces (amonst them, indentation)
-- vim.opt.listchars:append 'eol:↴'

require('indent_blankline').setup({
  char = '▏',
  context_char = '▏',
  show_current_context = true,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
})

-------------------------------------------------------------------------------
-- Statusbar
vim.opt.laststatus = 3 -- globalstatus for any bar

require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    theme = theme
  },

  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'diff', 'filename', 'diagnostics' },
    lualine_x = { 'encoding', 'fileformat' },
    lualine_y = { 'buffers' },
    lualine_z = { 'location' }
  },

  extensions = { 'nvim-tree' }
})
