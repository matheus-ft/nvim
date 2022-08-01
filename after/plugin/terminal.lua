require('nvterm').setup {
  terminals = {
    list = {},
    type_opts = {
      float = {
        relative = 'editor',
        row = 0.05,
        col = 0.1,
        width = 0.8,
        height = 0.8,
        border = 'single',
      },
      horizontal = { location = 'rightbelow', split_ratio = .3, },
      vertical = { location = 'rightbelow', split_ratio = .5 },
    }
  },
  behavior = {
    autoclose_on_quit = {
      enabled = false,
      confirm = true,
    },
    close_on_exit = true,
    auto_insert = true,
  },
}

local toggle_modes = {'n', 't'}
local mappings = {
  { toggle_modes, '<A-t>', function () require("nvterm.terminal").toggle("horizontal") end },
  { toggle_modes, '<A-v>', function () require("nvterm.terminal").toggle("vertical") end },
  { 'n', '<A-i>', '<cmd>lua require("nvterm.terminal").toggle("float")<cr><C-\\><C-n><cmd>set winblend=10<cr>i' },
  { 't', '<A-i>', '<cmd>lua require("nvterm.terminal").toggle("float")<cr><C-\\><C-n><cmd>set winblend=10<cr>' },
}
local opts = { noremap = true, silent = true }
for _, mapping in ipairs(mappings) do
  vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
end

