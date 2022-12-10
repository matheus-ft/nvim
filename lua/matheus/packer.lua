-- Bootstrapping
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  BOOTSTRAP = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- This way the plugins are updated everytime this file is writen (don't know why, but it seems to not work if done purely in Lua)
vim.cmd [[
  augroup packer
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]]

local packer = require('packer')

-----------------------------------
-- borrowed from ChristianChiarulli:
-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
})
-----------------------------------

-- Plugins
return packer.startup({ function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- To make neovim start faster (not sure it actually helps, tho)
  use {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient') -- this has to be called early in the config without `.setup()`
    end
  }

  -- Mason sub package manager
  use {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ﮊ",
          },
        }
      })
    end
  }

  -- Useful aesthetics
  use 'lewis6991/gitsigns.nvim' -- git hints and git blame
  use 'lukas-reineke/indent-blankline.nvim' -- indentation guides
  use {
    'nvim-lualine/lualine.nvim', -- status bar
    'akinsho/bufferline.nvim', -- tab bar
    { 'kyazdani42/nvim-tree.lua', -- file tree
      requires = { 'kyazdani42/nvim-web-devicons', }, }
  }
  use {
    'nacro90/numb.nvim', -- to peek line jumps with `:<number>`
    config = function() require('numb').setup() end
  }
  use 'karb94/neoscroll.nvim' -- smooth scrolling with <C-u> and <C-d>
  use 'norcalli/nvim-colorizer.lua' -- colorize hexcodes and color-indicating text
  use 'rcarriga/nvim-notify'

  -- Actually useful
  use {
    'windwp/nvim-autopairs', -- completes the pair of surrounding chars
    config = function() require('nvim-autopairs').setup() end
  }
  use {
    'kylechui/nvim-surround', -- to change surrounding characters easily
    config = function() require('nvim-surround').setup() end
  }
  use 'numToStr/Comment.nvim' -- toggle comments easily
  -- use 'NvChad/nvterm' -- vscode-like horizontal/vertical terminal
  use {
    'stevearc/aerial.nvim', -- lists all functions in the file
    config = function() require('aerial').setup() end
  }
  use { "cshuaimin/ssr.nvim", module = "ssr" } -- search and replace
  use { 'mg979/vim-visual-multi', branch = 'master' } -- <C-n> marks same words successively

  -- Autocompletion stuff
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use { 'kkoomen/vim-doge', run = ':call doge#install()' } -- docs

  -- LSP stuff
  use 'neovim/nvim-lspconfig'
  use "williamboman/mason-lspconfig.nvim"
  use 'folke/trouble.nvim' -- lists problems like most IDEs
  use 'RRethy/vim-illuminate' -- highlights same words in scope
  use {
    'ray-x/lsp_signature.nvim', -- adds function signature helper pop-up
    config = function() require('matheus.lsp.signature') end
  }
  use { 'glepnir/lspsaga.nvim', branch = 'main' }
  use { 'RishabhRD/nvim-lsputils',
    requires = 'RishabhRD/popfix', -- also requires `bat` to work properly
    config = function() require('matheus.lsp.utils') end -- this makes the lsp actions behave a lil better (but I don't actually understand it)
  }
  use {
    'rmagatti/goto-preview', -- opens definitions/declarations/etc in a pop-up window
    config = function() require('goto-preview').setup({ default_mappings = true }) end
  }

  -- Sintax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Markdown, latex, etc.
  use {
    'iamcco/markdown-preview.nvim', run = 'cd app && npm install',
    setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }
  }

  -- Notebooks
  use 'goerz/jupytext.vim'
  use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' } -- sorts the findings
    }
  }

  -- Themes
  use 'navarasu/onedark.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'NTBBloodbath/doom-one.nvim'

  if BOOTSTRAP then
    require('packer').sync()
  end
end })
