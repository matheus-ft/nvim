local keymap = vim.keymap.set
local noremap = { noremap = true }
local ssr = require("ssr")

-- Search and replace
keymap('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', noremap) -- this becomes `rename` if a language server is active
keymap('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>', noremap)
keymap({ 'v', 'x' }, '<leader>r', '"ry:%s/\\<<C-r>r\\>/<C-r>r/gI<Left><Left><Left>', noremap) -- trying to replace selection text (using 'r' register)
keymap({ 'v', 'x' }, '<leader>s', '"ry:%s/\\<<C-r>r\\>//gI<Left><Left><Left>', noremap)
keymap({ 'n', 'i' }, '<C-f>', '<Esc>/', noremap)
keymap({ 'v', 'x' }, '<C-f>', '"sy/<C-r>s', noremap) -- using the 's' register

keymap({ "n", "x" }, "<leader>sr", function() ssr.open() end, noremap)

ssr.setup {
  min_width = 50,
  min_height = 5,
  keymaps = {
    close = "q",
    next_match = "n",
    prev_match = "N",
    replace_all = "<leader><cr>",
  },
}
