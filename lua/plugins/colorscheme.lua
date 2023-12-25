-- vim.cmd.colorscheme('retrobox')

return {
  'olimorris/onedarkpro.nvim',
  priority = 1000, -- Ensure it loads first
  config = function()
    vim.opt.termguicolors = true
    require('onedarkpro').setup({
      options = {
        transparency = false,
      },
    })
    vim.cmd.colorscheme('onedark')
  end,
}
