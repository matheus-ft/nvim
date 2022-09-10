-------------------
-- Specific settings
-------------------
vim.opt_local.colorcolumn = '80'
vim.cmd([[ highlight ColorColumn guibg=yellow ]])

vim.keymap.set({'n', 'i'}, '<F9>', '<cmd>!source .env/bin/activate && python3 %<cr>', { noremap = true })

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

-- this formats the current python buffer with black (and docformatter)
-- make sure your local virtual environment is named .env
autocmd('BufWritePost', {
        pattern = '*.py',
        command = '!source .env/bin/activate && docformatter -ir % && black %',
        group = PYTHON
})

