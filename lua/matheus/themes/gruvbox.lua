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
    -- keeping the SignColumn with same color as background
    GruvboxRedSign = { bg = '#282828' },
    GruvboxGreenSign = { bg = '#282828' },
    GruvboxYellowSign = { bg = '#282828' },
    GruvboxBlueSign = { bg = '#282828' },
    GruvboxPurpleSign = { bg = '#282828' },
    GruvboxAquaSign = { bg = '#282828' },
    GruvboxOrangeSign = { bg = '#282828' },
  },
  transparent_mode = true,
})

vim.o.background = 'dark'

vim.cmd.colorscheme(Gruvbox)

return Gruvbox
