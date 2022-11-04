vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

vim.keymap.set({ 'n', 'i' }, '<F9>', '<cmd>so %<cr>', { noremap = true }) -- probably only works in nvim, since i dont have lua locally
