-- Bootstrapping
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  NEED_BOOTSRAP =
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- This way the plugins are updated everytime this file is writen (don't know why, but it seems to not work if done purely in Lua)
vim.cmd([[
  augroup packer
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

local packer = require('packer')

-----------------------------------
-- borrowed from ChristianChiarulli:
-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})
-----------------------------------

-- Plugins
return packer.startup({
  function(use)
    -- Packer manages itself
    use('wbthomason/packer.nvim')

    -- To make neovim start faster (not sure it actually helps, tho)
    use({
      'lewis6991/impatient.nvim',
      config = function()
        require('impatient') -- this has to be called early in the config and without `.setup()`
      end,
    })

    -- "sub package manager"
    use('williamboman/mason.nvim')

    -- Git
    use('lewis6991/gitsigns.nvim') -- git hints and git blame
    use('tpope/vim-fugitive') -- git commands

    -- Useful aesthetics
    use('nvim-lualine/lualine.nvim')
    use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })
    use('lukas-reineke/indent-blankline.nvim') -- indentation guides
    use('nacro90/numb.nvim') -- to peek line jumps with `:<number>`
    use('norcalli/nvim-colorizer.lua') -- colorize hexcodes and color-indicating text
    use('rcarriga/nvim-notify')
    use({ 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' })

    -- Actually useful
    use({
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup()
      end,
    }) -- completes the pair of chars
    use({
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup()
      end,
    }) -- to change surrounding chars easily
    use('numToStr/Comment.nvim') -- toggle comments easily
    use({ 'cshuaimin/ssr.nvim', module = 'ssr' }) -- structural search and replace
    use('folke/which-key.nvim')
    use({ 'mg979/vim-visual-multi', branch = 'master' }) -- <C-n> marks same words successively (like <C-d> in VSCo**)
    use('stevearc/aerial.nvim') -- lists all functions in the file
    use({
      'vimwiki/vimwiki',
      config = function()
        require('matheus.wiki') -- needs to be called before plugin actually loads
      end,
    })
    use('mbbill/undotree')

    -- Sintax highlighting
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }) -- Highlight, edit, and navigate code
    use({ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }) -- Additional text objects

    -- LSP stuff
    use({
      'neovim/nvim-lspconfig',
      requires = {
        'williamboman/mason-lspconfig.nvim',
        'folke/trouble.nvim', -- lists problems like most IDEs
        'RRethy/vim-illuminate', -- highlights same words in scope
        { 'glepnir/lspsaga.nvim', branch = 'main' },
        'rmagatti/goto-preview', -- opens definitions/declarations/etc in a pop-up window
        {
          'RishabhRD/nvim-lsputils', -- this makes the lsp actions behave a lil better (but I don't actually understand it)
          requires = 'RishabhRD/popfix', -- also requires `bat` to work properly
        },
        'j-hui/fidget.nvim', -- Useful status updates for LSP
        'folke/neodev.nvim', -- Additional lua configuration, makes nvim stuff amazing
        'ray-x/lsp_signature.nvim', -- adds function signature helper pop-up
        'mhartington/formatter.nvim',
      },
    })

    -- Autocompletion stuff
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        { 'kkoomen/vim-doge', run = ':call doge#install()' },
      },
    })

    -- Markdown, latex, etc.
    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
      ft = { 'markdown' },
    })

    -- Notebooks
    use('goerz/jupytext.vim')
    use({ 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' })

    -- Telescope
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzy-native.nvim', -- sorts the findings
      },
    })

    -- Themes
    use('navarasu/onedark.nvim')
    use({ 'catppuccin/nvim', as = 'catppuccin' })
    use('NTBBloodbath/doom-one.nvim')

    if NEED_BOOTSRAP then
      require('packer').sync()
    end
  end,
})
