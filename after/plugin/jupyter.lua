vim.g.jupytext_fmt = 'py:percent'

local noremap = { noremap = true }
local expr = { noremap = true, expr = true }
vim.keymap.set('n', '<leader>v', 'nvim_exec("MagmaEvaluateOperator", v:true)', expr)
vim.keymap.set({'v', 'x'}, '<S-CR>', '<cmd>MagmaEvaluateVisual<CR>', noremap)
vim.keymap.set({'n', 'i'}, '<S-CR>', '<Esc>vip<cmd>MagmaEvaluateLine<CR><Esc>', noremap)
vim.keymap.set({'n', 'i'}, '<C-CR>', '<cmd>MagmaEvaluateLine<CR>', noremap)
vim.keymap.set('n', '<leader>j', '<cmd>MagmaShowOutput<CR>', noremap)

vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = "ueberzug"

