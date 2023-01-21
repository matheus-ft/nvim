vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.nu = true
vim.opt.relativenumber = true -- to easily jump vertically in the file

vim.opt.hidden = true -- keeps edited buffers in the background, so there's no need to always save before navigating away from it
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.ignorecase = true -- ignore case while searching...
vim.opt.smartcase = true -- ... unless there's a capital letter
vim.opt.incsearch = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- allows for 'native fuzzy finding' if nvim is opened at project root
vim.opt.path:append({ '**' })
vim.opt.wildmenu = true
vim.opt.completeopt = { 'menuone', 'preview', 'noinsert' }

vim.opt.title = true -- to show file name in titlebar
vim.opt.cmdheight = 1

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.equalalways = false

vim.opt.cursorline = true
vim.opt.mouse = 'nv'
vim.opt.showmode = false
vim.cmd([[set iskeyword+=-]]) -- makes hifen separated 'words' a single word

if vim.g.neovide then
  require('plugin.neovide')
end

vim.g.python3_host_prog = os.getenv('HOME') .. '/.local/venv/nvim/bin/python'
vim.opt.termguicolors = true

-- disable not used plugins -- shaving off some ms
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
