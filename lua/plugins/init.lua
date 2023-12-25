return {
  {
    'williamboman/mason.nvim', -- package manager
    config = function()
      require('mason').setup()
    end,
  },
}
