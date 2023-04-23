vim.opt_local.textwidth = 80
vim.opt.spell = true
local noremap = require('matheus').noremap

noremap('v', '<C-i>', [[c\textit{<Esc>pa}<Esc>]], 'Add italics to selection')
noremap('v', '<C-b>', [[c\textbf{<Esc>pa}<Esc}]], 'Add bold to selection')
noremap('n', '<C-i>', [[ciw\textit{<Esc>pa}<Esc>]], 'Add italics to current word')
noremap('n', '<C-b>', [[ciw\textbf{<Esc>pa}<Esc>]], 'Add bold to current word')

local ok, autopairs = pcall(require, 'nvim-autopairs')
if ok then
  local Rule = require('nvim-autopairs.rule')
  autopairs.add_rules({ Rule('$', '$', 'tex') })
end
