Gruvbox = 'gruvbox'

require(Gruvbox).setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = 'soft', -- can be "hard", "soft" or empty string
  overrides = {
    String = { italic = false },
  },
  transparent_mode = true,
})

vim.o.background = 'dark'

vim.cmd.colorscheme(Gruvbox)

return Gruvbox
