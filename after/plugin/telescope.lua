local telescope = require("telescope")
local noremap = { noremap = true }
local key = vim.keymap.set
local actions = require('telescope.actions')

key('n', '<leader>pf', ':lua require("telescope.builtin").find_files()<CR>', noremap)
key('n', '<leader>ps', ':lua require("telescope.builtin").live_grep()<CR>', noremap)
key('n', '<leader>pb', ':lua require("telescope.builtin").buffers()<CR>', noremap)
key('n', '<leader>h', ':lua require("telescope.builtin").help_tags()<CR>', noremap)
key('n', '<leader>pd', ':Telescope diagnostics<CR>', noremap)


-- borrowed from NvChad
local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "> ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.90,
      height = 0.90,
      preview_cutoff = 120,
    },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    path_display = { "truncate" },
    mappings = {
      n = { ["q"] = actions.close },
    },
  },

  extensions_list = { "fzy_native" },
}

telescope.setup(options)

-- load extensions
pcall(function()
  for _, ext in ipairs(options.extensions_list) do
    telescope.load_extension(ext)
  end
end)
