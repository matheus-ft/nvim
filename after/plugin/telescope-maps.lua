local noremap = { noremap = true }

vim.keymap.set('n', '<leader>pf', ':lua require("matheus.telescope-config").project_files()<CR>', noremap)
vim.keymap.set('n', '<leader>ps', ':lua require("telescope.builtin").live_grep()<CR>', noremap)
vim.keymap.set('n', '<leader>pu', ':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<CR>', noremap)
vim.keymap.set('n', '<leader>b',  ':lua require("telescope.builtin").buffers()<CR>', noremap)
vim.keymap.set('n', '<leader>a',  ':lua require("telescope.builtin").help_tags()<CR>', noremap)
vim.keymap.set('n', '<leader>pd', ':Telescope diagnostics<CR>', noremap)

