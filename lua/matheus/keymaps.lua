vim.g.mapleader = ' '
local all_modes = { 'n', 'i', 'v', 'x' }
local noremap = require('matheus').noremap
local map = require('matheus').map
local silent = { silent = true }

noremap('n', '<leader><leader>', ':', 'Command mode')
noremap({ 'n', 'i' }, '<F9>', '<cmd>so %<cr>', 'Run script')

noremap('n', 'Q', '<nop>')
noremap('n', 'ZZ', '<nop>')

map({ 'i', 'n' }, '<C-c>', '<Esc>', 'Escape')
noremap('n', '<Esc>', '<cmd>nohlsearch<cr>')

map('n', '<C-u>', '<C-u>zz', 'Scroll up')
map('n', '<C-d>', '<C-d>zz', 'Scroll down')
noremap('n', '<PageUp>', '<C-u>', 'Half page up') -- decreasing the jump amount
noremap('n', '<PageDown>', '<C-d>', 'Half page down')

-- Resize with arrows
noremap(all_modes, '<C-Left>', ':vertical resize -2<CR>', 'Decrease horizontal split')
noremap(all_modes, '<C-Right>', ':vertical resize +2<CR>', 'Increase horizontal split')

noremap('n', '<Left>', '<nop>')
noremap('n', '<Right>', '<nop>')
-- Move the page but not the cursor with the arrow keys
noremap('n', '<Down>', '<C-e>', 'Micro scroll down')
noremap('n', '<Up>', '<C-y>', 'Micro scroll up')

-- Splits navigation
noremap('n', '<C-h>', '<C-w>h', 'Move to left split')
noremap('n', '<C-j>', '<C-w>j', 'Move to bottom split')
noremap('n', '<C-k>', '<C-w>k', 'Move to top split')
noremap('n', '<C-l>', '<C-w>l', 'Move to right split')

-- Make splits
noremap('n', '<leader>y', '<C-w>v', 'Vertical split')
noremap('n', '<leader>x', '<C-w>s', 'Horizontal split')
noremap('n', '<leader>o', '<C-w>o', 'Only keep current window')

-- Buffer handling
noremap('n', '<A-h>', ':bprevious<CR>', 'Previous buffer', silent)
noremap('n', '<A-l>', ':bnext<CR>', 'Next buffer', silent)
noremap('n', '<leader>q', ':q<CR>', 'Quit', silent)
noremap('n', '<leader>e', ':edit ', 'New buffer')

noremap('n', '<C-->', ':bdelete<CR>', 'Delete buffer', silent)
noremap('n', '<A-w>', ':up<CR>', 'Write buffer', silent)
noremap('n', '<A-o>', ':!cp % ', 'Copy buffer')
noremap('n', '<A-O>', ':!mv % ', 'Rename buffer')
noremap({ 'n', 'i' }, '<F5>', '<Esc>yyp', 'Repeat current line below', silent)

-- indent/unindent with tab/shift-tab
noremap('n', '<Tab>', '>>', 'Indent line')
noremap('n', '<S-tab>', '<<', 'Unindent line')
noremap('i', '<S-Tab>', '<Esc><<i')
noremap('v', '<Tab>', '>gv')
noremap('v', '<S-Tab>', '<gv')

-- Move lines up and down
noremap('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
noremap('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
noremap('v', '<A-j>', [[:m '>+1<CR>gv=gv]])
noremap('v', '<A-k>', [[:m '<-2<CR>gv=gv]])

-- Quick navigation in insert mode
noremap('i', '<C-h>', '<Left>')
noremap('i', '<C-j>', '<Down>')
noremap('i', '<C-k>', '<Up>')
noremap('i', '<C-l>', '<Right>')

-- emacs-like bindings
noremap('i', '<C-b>', '<Left>')
noremap('i', '<C-f>', '<Right>')
noremap('i', '<C-a>', '<Esc>^i')
noremap('i', '<C-e>', '<Esc>$a')

-- paste what was last yanked
noremap('n', 'yp', [["0p]], 'Paste last yanked')
noremap('n', 'yP', [["0P]], 'Paste last yanked before cursor')

-- Interacting with system clipboard (don't forget to install utility to activate the registers)
noremap({ 'v', 'x' }, '<C-c>', [["+y]], 'Copies into clipboard')
noremap('n', 'my', [["+y]], 'Copies into clipboard')
noremap('n', 'mY', [["+Y]], 'Copies rest of the line into clipboard')
noremap('n', 'mp', [["+p]], 'Paste from clipboard')
noremap('n', 'mP', [["+P]], 'Paste from clipboard before cursor')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
noremap('n', 'n', "'Nn'[v:searchforward].'zv'", 'Next search result', { expr = true })
noremap('x', 'n', "'Nn'[v:searchforward]", 'Next search result', { expr = true })
noremap('o', 'n', "'Nn'[v:searchforward]", 'Next search result', { expr = true })
noremap('n', 'N', "'nN'[v:searchforward].'zv'", 'Prev search result', { expr = true })
noremap('x', 'N', "'nN'[v:searchforward]", 'Prev search result', { expr = true })
noremap('o', 'N', "'nN'[v:searchforward]", 'Prev search result', { expr = true })
