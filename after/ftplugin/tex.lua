vim.opt_local.textwidth = 80
vim.opt.spell = true
local noremap = require('matheus').noremap

noremap('i', '<C-i>', [[\textit{}<Left>]], 'Inserts italics')
noremap('i', '<C-b>', [[\textbf{}<Left>]], 'Inserts bold')
noremap('n', '<C-i>', [[viwdi\textit{<Esc>pa}<Esc>]], 'Add italics to current word')
noremap('n', '<C-b>', [[viwdi\textbf{<Esc>pa}<Esc>]], 'Add bold to current word')

local ok, autopairs = pcall(require, 'nvim-autopairs')
if ok then
  local Rule = require('nvim-autopairs.rule')
  autopairs.add_rules({ Rule('$', '$', 'tex') })
end
