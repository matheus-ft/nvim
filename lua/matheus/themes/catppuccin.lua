require("catppuccin").setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  term_colors = true,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    lsp_trouble = true,
    illuminate = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    mason = true,
    notify = true,
    harpoon = true,
    indent_blankline = { enabled = true },
    native_lsp = { enabled = true }
  },
})

vim.cmd.colorscheme "catppuccin"

local ok, bufferline = pcall(require, "bufferline")
if ok then
  bufferline.setup({
    highlights = require("catppuccin.groups.integrations.bufferline").get()
  })
end

vim.api.nvim_set_hl(0, "LineNr", { fg = "#5b6268" }) -- original grey was too light

return "catppuccin"
