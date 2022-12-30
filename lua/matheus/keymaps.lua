vim.g.mapleader = ' '
local all_modes = { 'n', 'i', 'v', 'x' }
local noremap = require('matheus').noremap
local map = require('matheus').map
local silent = { silent = true }

noremap('n', '<leader><leader>', ':', 'Command mode')
noremap({ 'n', 'i' }, '<F9>', '<cmd>so %<cr>', 'Run script')

noremap({ 'n', 'v', 'x' }, '<leader>', '<nop>')
noremap('n', 'Q', '<nop>')
noremap('n', 'ZZ', '<nop>')

map({ 'i', 'n' }, '<C-c>', '<Esc>', 'Escape')
noremap('t', '<Esc>', '<C-\\><C-n>') -- to enter normal mode with a terminal open
noremap('n', '<Esc>', '<cmd>nohlsearch<cr>')

map('n', '<C-u>', '<C-u>zz', 'Scroll up')
map('n', '<C-d>', '<C-d>zz', 'Scroll down')
noremap('n', '<PageUp>', '<C-u>', 'Half page up') -- decreasing the jump amount
noremap('n', '<PageDown>', '<C-d>', 'Half page down')

-- Resize with arrows
noremap(all_modes, '<C-Up>', ':resize -2<CR>', 'Decrease horizontal split')
noremap(all_modes, '<C-Down>', ':resize +2<CR>', 'Increase horizontal split')
noremap(all_modes, '<C-Left>', ':vertical resize -2<CR>', 'Decrease horizontal split')
noremap(all_modes, '<C-Right>', ':vertical resize +2<CR>', 'Increase horizontal split')

-- Splits navigation
noremap('n', '<C-h>', '<C-w>h', 'Move to left split')
noremap('n', '<C-j>', '<C-w>j', 'Move to bottom split')
noremap('n', '<C-k>', '<C-w>k', 'Move to top split')
noremap('n', '<C-l>', '<C-w>l', 'Move to right split')

-- Make splits
noremap('n', '<leader>y', '<C-w>v', 'Vertical split')
noremap('n', '<leader>x', '<C-w>s', 'Horizontal split')

-- Buffer handling
noremap('n', '<A-h>', ':bprevious<CR>', 'Previous buffer', silent)
noremap('n', '<A-l>', ':bnext<CR>', 'Next buffer', silent)
noremap('n', '<leader>q', ':q<CR>', 'Quit', silent)
noremap('n', '<leader>cb', ':bdelete<CR>', 'Close buffer', silent)
noremap('n', '<leader>w', ':up<CR>', 'Write buffer', silent)
noremap(all_modes, '<C-s>', '<Esc>:up<CR>', 'Save buffer', silent)
noremap('n', '<leader>o', ':edit<Space>', 'Open buffer')

-- indent/unindent with tab/shift-tab
noremap('n', '<Tab>', '>>', 'Indent line')
noremap('n', '<S-tab>', '<<', 'Unindent line')
noremap('i', '<S-Tab>', '<Esc><<i')
noremap('v', '<Tab>', '>gv')
noremap('v', '<S-Tab>', '<gv')

-- Move the page but not the cursor with the arrow keys
noremap('n', '<Down>', '<C-e>', 'Micro scroll down')
noremap('n', '<Up>', '<C-y>', 'Micro scroll up')
noremap('n', '<Left>', '<nop>')
noremap('n', '<Right>', '<nop>')

-- Move lines up and down
noremap('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
noremap('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
noremap('v', '<A-j>', [[ :m '>+1<CR>gv=gv ]])
noremap('v', '<A-k>', [[ :m '<-2<CR>gv=gv ]])

-- Some insert mode keybindings that might be useful
noremap('i', '<C-h>', '<Left>')
noremap('i', '<C-j>', '<Down>')
noremap('i', '<C-k>', '<Up>')
noremap('i', '<C-l>', '<Right>')

-- emacs-like bindings
noremap('i', '<C-b>', '<Left>')
noremap('i', '<C-f>', '<Right>')
noremap('i', '<C-a>', '<Esc>^i')
noremap('i', '<C-e>', '<Esc>$a')

noremap('n', 'yY', 'y^', 'Start of line (non-blank)')
noremap('n', 'dD', 'd^', 'Start of line (non-blank)')
noremap('n', 'cC', 'c^', 'Start of line (non-blank)')

-- paste what was last yanked, not what was deleted
noremap('n', 'yp', [[ "0p ]], 'Paste last yanked')
noremap('n', 'yP', [[ "0P ]], 'Paste last yanked before cursor')

-- Interacting with system clipboard (don't forget to install utility to activate the registers)
noremap({ 'v', 'x' }, '<C-c>', [[ "+y ]], 'Copies into clipboard')
-- noremap('i', '<C-v>', '<C-r>+', 'Pastes from clipboard')
noremap('n', 'my', [[ "+y ]], 'Copies into clipboard')
noremap('n', 'mY', [[ "+Y ]], 'Copies rest of the line into clipboard')
noremap('n', 'mp', [[ "+p ]], 'Paste from clipboard')
noremap('n', 'mP', [[ "+P ]], 'Paste from clipboard before cursor')
