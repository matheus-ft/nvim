-------------------
-- Specific settings
-------------------

-- make sure you activate your venv before entering nvim!!
vim.keymap.set({ 'n', 'i' }, '<F9>', '<cmd>!python3 %<cr>', { noremap = true })

-------------
-- Auto pairs
-------------
local ok, autopairs = pcall(require('nvim-autopairs'))
if ok then
  local Rule = require('nvim-autopairs.rule')
  autopairs.add_rules(
    { Rule("f'", "'", 'python') },
    { Rule('f"', '"', 'python') },
    { Rule("r'", "'", 'python') },
    { Rule('r"', '"', 'python') },
    { Rule("b'", "'", 'python') },
    { Rule('b"', '"', 'python') }
  )
end

----------------
-- Auto commands
----------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

PYTHON = augroup('PYTHON', { clear = true })
