local noremap = { noremap = true }
local key = vim.keymap.set

key('n', '<leader>pf',     ':lua require("matheus.telescope-config").project_files()<CR>', noremap)
key('n', '<leader>ps',     ':lua require("telescope.builtin").live_grep()<CR>', noremap)
key('n', '<leader>pu',     ':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<CR>', noremap)
key('n', '<leader><Tab>',  ':lua require("telescope.builtin").buffers()<CR>', noremap)
key('n', '<leader>a',      ':lua require("telescope.builtin").help_tags()<CR>', noremap)
key('n', '<leader>pd',     ':Telescope diagnostics<CR>', noremap)

