--------------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------------
require('matheus.packer')

--------------------------------------------------------------------------------------
-- Settings
--------------------------------------------------------------------------------------
require('matheus.keymaps')
require('matheus.options')

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
  callback = function() vim.highlight.on_yank({ timeout = 200, higroup = 'IncSearch' }) end,
  group    = MATHEUS
})

-- Don't autocomment new lines -- adapted from https://github.com/nvim-lua/kickstart.nvim/pull/88
autocmd('BufEnter', { pattern = '*', command = 'set fo-=c fo-=r fo-=o', group = MATHEUS }) -- mostly useful for Lua
