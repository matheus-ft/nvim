require('matheus').noremap('n', '<leader>u', vim.cmd.UndotreeToggle, 'Undotree', { silent = true })

vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'

-- check in https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim#L27
vim.g.undotree_WindowLayout = 3
vim.g.undotree_SetFocusWhenToggle = 1
