-- Add color to cursor
vim.g.doom_one_cursor_coloring = true
-- Set :terminal colors
vim.g.doom_one_terminal_colors = true
-- Enable italic comments
vim.g.doom_one_italic_comments = true
-- Enable TS support
vim.g.doom_one_enable_treesitter = true
-- Color whole diagnostic text or only underline
vim.g.doom_one_diagnostics_text_color = true
-- Enable transparent background
vim.g.doom_one_transparent_background = false -- this one is broken!!

-- Pumblend transparency
vim.g.doom_one_pumblend_enable = false
vim.g.doom_one_pumblend_transparency = 20

-- Plugins integration
vim.g.doom_one_plugin_telescope = true
vim.g.doom_one_plugin_nvim_tree = true
vim.g.doom_one_plugin_indent_blankline = true
vim.g.doom_one_plugin_vim_illuminate = true
vim.g.doom_one_plugin_lspsaga = true

vim.cmd([[colorscheme doom-one]])

vim.api.nvim_set_hl(0, 'LineNr', { bg = 'bg', fg = '#5b6268' }) -- original grey was too light
vim.api.nvim_set_hl(0, 'Comment', { fg = '#5b6268', italic = true }) -- original grey was too light

return 'auto' -- this is used by lualine, as it does not recognize 'doom-one' as theme
