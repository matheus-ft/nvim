local noremap = { noremap = true }
local key = vim.keymap.set
local actions = require('telescope.actions')

key('n', '<leader>pf', ':lua require("telescope.builtin").find_files()<CR>', noremap)
key('n', '<leader>ps', ':lua require("telescope.builtin").live_grep()<CR>', noremap)
key('n', '<leader>pu', ':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<CR>', noremap)
key('n', '<leader><Tab>', ':lua require("telescope.builtin").buffers()<CR>', noremap)
key('n', '<leader>a', ':lua require("telescope.builtin").help_tags()<CR>', noremap)
key('n', '<leader>pd', ':Telescope diagnostics<CR>', noremap)

require('telescope').setup({
  defaults = {
    initial_mode = 'insert',
    mappings = {
      i = {
        ['<esc>'] = actions.close
      },
    },
  }
})

require('telescope').load_extension('fzy_native')
