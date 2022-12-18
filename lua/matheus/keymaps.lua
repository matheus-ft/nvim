vim.g.mapleader = ' '
local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }
local all_modes = { 'n', 'i', 'v', 'x' }
local visual = { 'v', 'x' }
local keymap = vim.keymap.set

keymap('n', '<leader>', '<nop>')
keymap('n', '<leader><leader>', ':', noremap)
keymap({ 'n', 'i' }, '<F9>', '<cmd>so %<cr>', noremap)
keymap('i', '<C-c>', '<Esc>')
keymap('n', 'ZZ', '<nop>')
keymap('n', 'Q', '<nop>')
keymap('n', '<Esc>', '<cmd>nohlsearch<cr>', noremap)
keymap('t', '<Esc>', '<C-\\><C-n>', noremap) -- to enter normal mode with a terminal open

keymap('n', '<C-u>', '<C-u>zz')
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<PageUp>', '<C-u>')
keymap('n', '<PageDown>', '<C-d>')

-- Resize with arrows
keymap(all_modes, '<C-Up>', ':resize -2<CR>', silent_noremap)
keymap(all_modes, '<C-Down>', ':resize +2<CR>', silent_noremap)
keymap(all_modes, '<C-Left>', ':vertical resize -2<CR>', silent_noremap)
keymap(all_modes, '<C-Right>', ':vertical resize +2<CR>', silent_noremap)

-- Make splits
keymap('n', '<leader>y', '<C-w>v', noremap)
keymap('n', '<leader>x', '<C-w>s', noremap)
keymap('n', '<leader>o', '<C-w>o', noremap)

-- Splits navigation
keymap('n', '<C-h>', '<C-w>h', noremap)
keymap('n', '<C-j>', '<C-w>j', noremap)
keymap('n', '<C-k>', '<C-w>k', noremap)
keymap('n', '<C-l>', '<C-w>l', noremap)

-- Buffer handling
keymap('n', '<A-h>', ':bprevious<CR>', silent_noremap)
keymap('n', '<A-l>', ':bnext<CR>', silent_noremap)
keymap('n', '<leader>cb', ':bdelete<CR>', silent_noremap)
keymap('n', '<leader>q', ':q<CR>', silent_noremap)
keymap('n', '<leader>w', ':w<CR>', silent_noremap)
keymap({ 'n', 'i' }, '<C-s>', '<Esc>:w<CR>', silent_noremap)
keymap('n', '<leader>e', ':edit<Space>', noremap)

-- indent/unindent with tab/shift-tab
keymap('n', '<Tab>', '>>', noremap)
keymap('n', '<S-tab>', '<<', noremap)
keymap('i', '<S-Tab>', '<Esc><<i', noremap)
keymap('v', '<Tab>', '>gv', noremap)
keymap('v', '<S-Tab>', '<gv', noremap)

-- Move the page but not the cursor with the arrow keys
keymap('n', '<Down>', '<C-e>', noremap)
keymap('n', '<Up>', '<C-y>', noremap)
keymap('n', '<Left>', '<nop>', noremap)
keymap('n', '<Right>', '<nop>', noremap)

-- Move lines up and down
keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', noremap)
keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', noremap)
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", silent_noremap)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", silent_noremap)

-- Some insert mode keybindings that might be useful
keymap('i', '<C-h>', '<Left>', noremap)
keymap('i', '<C-j>', '<Down>', noremap)
keymap('i', '<C-k>', '<Up>', noremap)
keymap('i', '<C-l>', '<Right>', noremap)

-- emacs-like bindings
keymap('i', '<C-b>', '<Left>', noremap)
keymap('i', '<C-f>', '<Right>', noremap)
keymap('i', '<C-a>', '<Esc>^i', noremap)
keymap('i', '<C-e>', '<Esc>$a', noremap)

keymap(visual, 'H', '^', noremap)
keymap(visual, 'L', '$', noremap)
keymap('n', 'yH', 'y^', noremap) -- Y already does y$
keymap('n', 'dH', 'd^', noremap) -- D already does d$
keymap('n', 'cH', 'c^', noremap) -- C already does c$

-- paste what was last yanked, not what was deleted
keymap('n', 'yp', '"0p', noremap)
keymap('n', 'yP', '"0P', noremap)

-- Interacting with system clipboard (don't forget to install utility to activate the registers)
keymap(visual, '<C-c>', '"+y', noremap) -- copies into clipboard
keymap('i', '<C-v>', '<C-r>+', noremap) -- pastes from clipboard
keymap('n', 'cy', '"+y', noremap)
keymap('n', 'cY', '"+Y', noremap)
keymap('n', 'cp', '"+p', noremap)
keymap('n', 'cP', '"+P', noremap)
