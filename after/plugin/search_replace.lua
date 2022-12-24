local noremap = require('matheus').noremap
local ssr = require("ssr")

-- Search and replace
noremap('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Substitute word')
noremap({ 'v', 'x' }, '<leader>s', '"ry:%s/\\<<C-r>r\\>/<C-r>r/gI<Left><Left><Left>', 'Substitute selection') -- using 'r' register
noremap({ 'n', 'i' }, '<C-f>', '<Esc>/', 'Search')
noremap({ 'v', 'x' }, '<C-f>', '"sy/<C-r>s', 'Find selection') -- using the 's' register
noremap({ 'v', 'x' }, '/', '"sy/<C-r>s', 'Find selection')

noremap({ 'n', 'x' }, '<leader>sr', function() ssr.open() end, 'Structural search and replace')

ssr.setup {
  min_width = 50,
  min_height = 5,
  keymaps = {
    close = 'q',
    next_match = 'n',
    prev_match = 'N',
    replace_all = '<leader><cr>',
  },
}
