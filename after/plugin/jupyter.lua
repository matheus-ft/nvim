vim.g.jupytext_fmt = 'py:percent'

local noremap = { noremap = true }
local expr = { expr = true, noremap = true }
vim.keymap.set('n', '<leader>v', 'nvim_exec("MagmaEvaluateOperator", v:true)', expr)
vim.keymap.set({'v', 'x'}, '<S-CR>', ':MagmaEvaluateVisual<CR>', noremap)
vim.keymap.set({'n', 'i'}, '<S-CR>', '<Esc>vip:<BS><BS><BS><BS><BS>MagmaEvaluateVisual<CR>vip<Esc>', noremap)
vim.keymap.set({'n', 'i'}, '<C-CR>', ':MagmaEvaluateLine<CR>', noremap)
vim.keymap.set('n', '<leader>j', ':MagmaShowOutput<CR>', noremap)
-- vim.keymap.set('n', '<leader>?', ':noautocmd MagmaEnterOutput<CR>', noremap)

vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = "ueberzug"

