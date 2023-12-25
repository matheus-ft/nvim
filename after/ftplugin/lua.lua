local noremap = require('matheus').noremap

vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

noremap({ 'n', 'i' }, '<F9>', '<cmd>so %<cr>', 'Run script') -- probably only works in nvim, since i dont have lua locally
