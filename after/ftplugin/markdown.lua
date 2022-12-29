local noremap = require('matheus').noremap

vim.opt_local.textwidth = 120
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

noremap('i', '<C-i>', '**<Left>', 'Italics')
noremap('i', '<C-b>', '****<Left><Left>', 'Bold')

local ok, autopairs = pcall(require, 'nvim-autopairs')
if ok then
  local Rule = require('nvim-autopairs.rule')
  autopairs.add_rules({ Rule('*', '*', 'markdown') })
end
