--------------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------------
require('matheus.packer')

--------------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------------
require('matheus.keymaps')

--------------------------------------------------------------------------------------
-- Auto commands
--------------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

MATHEUS = augroup('MATHEUS', { clear = true })

-- trims all trailing whitespaces on save
autocmd('BufWritePre', { pattern = '*', command = '%s/\\s\\+$//e', group = MATHEUS })

-- highligths yanked text
autocmd('TextYankPost', {
  pattern  = '*',
  callback = function()
    vim.highlight.on_yank({ timeout=200, higroup='IncSearch' })
  end,
  group = MATHEUS
})

