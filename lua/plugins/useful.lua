return {
  'mg979/vim-visual-multi', -- <C-n> marks same words successively (no need to setup)
  {
    'windwp/nvim-autopairs', -- completes the pair of chars
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'kylechui/nvim-surround', -- to change surrounding chars easily
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    'andymass/vim-matchup', -- better % command for non curly-braces languages
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  {
    'numToStr/Comment.nvim', -- toggle comments easily
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'nacro90/numb.nvim', -- to peek line jumps with `:<number>`
    config = function()
      require('numb').setup()
    end,
  },
}
