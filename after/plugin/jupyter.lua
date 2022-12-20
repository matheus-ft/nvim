vim.g.jupytext_fmt = 'py:percent'

local noremap = require('matheus').noremap
noremap('n', '<leader>v', 'nvim_exec("MagmaEvaluateOperator", v:true)', 'Python: eval operator', { expr = true })
noremap({ 'v', 'x' }, '<S-CR>', ':MagmaEvaluateVisual<CR>', 'Python: run selection')
noremap({ 'n', 'i' }, '<S-CR>', '<Esc>vip:<BS><BS><BS><BS><BS>MagmaEvaluateVisual<CR>vip<Esc>', 'Python: run cell')
noremap({ 'n', 'i' }, '<C-CR>', ':MagmaEvaluateLine<CR>', 'Python: run line')
noremap('n', '<leader>j', ':MagmaShowOutput<CR>', 'Python: show run')
-- vim.keymap.set('n', '<leader>?', ':noautocmd MagmaEnterOutput<CR>', 'Python: enter output window')

vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = 'ueberzug' -- TODO: change this, because ueberzug is deprecated
