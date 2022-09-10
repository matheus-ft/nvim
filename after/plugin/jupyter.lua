vim.g.jupytext_fmt = 'py:percent'

local noremap = { noremap = true }
local expr = { noremap = true, expr = true }
vim.keymap.set('n', '<S-CR>', 'nvim_exec("MagmaEvaluateOperator", v:true)', expr)
vim.keymap.set('n', '<C-CR>', '<cmd>MagmaEvaluateLine<CR>', noremap)
vim.keymap.set({'v', 'x'}, '<C-CR>', '<cmd>MagmaEvaluateVisual<CR>', noremap)
vim.keymap.set('n', '<leader>j', '<cmd>MagmaShowOutput<CR>', noremap)

vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = "ueberzug"

