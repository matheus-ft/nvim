vim.g.mapleader = ' '

local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }
local all_modes = { 'n', 'i', 'v', 'x' }
local visual = { 'v', 'x' }

vim.keymap.set('n', '<leader><leader>', ':', noremap)
vim.keymap.set({ 'n', 'i' }, '<F9>', '<cmd>so %<cr>', noremap)
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', noremap)

-- to enter normal mode with a terminal open
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', noremap)

-- Resize with arrows
vim.keymap.set(all_modes, '<C-Up>', ':resize -2<CR>', silent_noremap)
vim.keymap.set(all_modes, '<C-Down>', ':resize +2<CR>', silent_noremap)
vim.keymap.set(all_modes, '<C-Left>', ':vertical resize -2<CR>', silent_noremap)
vim.keymap.set(all_modes, '<C-Right>', ':vertical resize +2<CR>', silent_noremap)

-- Make splits
vim.keymap.set('n', '<leader>y', '<C-w>v', noremap)
vim.keymap.set('n', '<leader>x', '<C-w>s', noremap)
vim.keymap.set('n', '<leader>o', '<C-w>o', noremap)

-- Splits navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', noremap)
vim.keymap.set('n', '<C-j>', '<C-w>j', noremap)
vim.keymap.set('n', '<C-k>', '<C-w>k', noremap)
vim.keymap.set('n', '<C-l>', '<C-w>l', noremap)

-- Buffer handling
vim.keymap.set('n', '<A-h>', ':bprevious<CR>', silent_noremap)
vim.keymap.set('n', '<A-l>', ':bnext<CR>', silent_noremap)
vim.keymap.set('n', '<leader>cb', ':bdelete<CR>', silent_noremap)
vim.keymap.set('n', '<leader>q', ':q<CR>', silent_noremap)
vim.keymap.set('n', '<leader>w', ':w<CR>', silent_noremap)
vim.keymap.set('n', '<leader>e', ':edit<Space>', noremap)

-- Replacing
vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', noremap) -- this becomes `refactor` if a language server is active
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>', noremap)
vim.keymap.set('v', '<leader>r', 'y:%s/\\<<C-r>0\\>/<C-r>0/gI<Left><Left><Left>', noremap)
vim.keymap.set('v', '<leader>s', 'y:%s/\\<<C-r>0\\>//gI<Left><Left><Left>', noremap)

-- indent/unindent with tab/shift-tab
vim.keymap.set('n', '<Tab>', '>>', noremap)
vim.keymap.set('n', '<S-tab>', '<<', noremap)
vim.keymap.set('i', '<S-Tab>', '<Esc><<i', noremap)
vim.keymap.set('v', '<Tab>', '>gv', noremap)
vim.keymap.set('v', '<S-Tab>', '<gv', noremap)

-- Move the page but not the cursor with the arrow keys
vim.keymap.set('n', '<Down>', '<C-e>', noremap)
vim.keymap.set('n', '<Up>', '<C-y>', noremap)
vim.keymap.set('n', '<Left>', 'nop', noremap)
vim.keymap.set('n', '<Right>', 'nop', noremap)

-- Move lines up and down
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', noremap)
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', noremap)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", noremap)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", noremap)

-- Some insert mode keybindings that might be useful
vim.keymap.set('i', '<C-h>', '<Left>', noremap)
vim.keymap.set('i', '<C-j>', '<Down>', noremap)
vim.keymap.set('i', '<C-k>', '<Up>', noremap)
vim.keymap.set('i', '<C-l>', '<Right>', noremap)
vim.keymap.set('i', '<C-b>', '<Esc>^i', noremap)
vim.keymap.set('i', '<C-e>', '<Esc>$a', noremap)

vim.keymap.set(visual, 'H', '^', noremap)
vim.keymap.set(visual, 'L', '$', noremap)
vim.keymap.set('n', 'yH', 'y^', noremap) -- Y already does y$
vim.keymap.set('n', 'dH', 'd^', noremap) -- D already does d$
vim.keymap.set('n', 'cH', 'c^', noremap) -- C already does c$

-- paste what was last yanked, not what was deleted
vim.keymap.set('n', 'yp', '"0p', noremap)
vim.keymap.set('n', 'yP', '"0P', noremap)
