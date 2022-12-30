local telescope = require('telescope')
local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')
local ok, wk = pcall(require, 'which-key')
local noremap = require('matheus').noremap
local silent = { silent = true }

if ok then
  wk.register({ ['<leader>p'] = 'Telescope' }, { mode = 'n' })
end
noremap('n', '<leader>pf', ':lua require("telescope.builtin").find_files()<CR>', 'Project files', silent)
noremap('n', '<leader>ps', ':lua require("telescope.builtin").live_grep()<CR>', 'Project search', silent)
noremap('n', '<leader>pb', ':lua require("telescope.builtin").buffers()<CR>', 'Project buffers', silent)
noremap('n', '<leader>h', ':lua require("telescope.builtin").help_tags()<CR>', 'Help', silent)
noremap('n', '<leader>pd', ':Telescope diagnostics<CR>', 'Project diagnostics', silent)
noremap('n', '<leader>pt', ':TodoTelescope<CR>', 'Project TODOs', silent)

-- borrowed from NvChad
telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '   ',
    selection_caret = '> ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
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
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    path_display = { 'truncate' },
    mappings = {
      n = {
        ['q'] = actions.close,
        ['<c-t>'] = trouble.open_with_trouble,
      },
      i = { ['<c-t>'] = trouble.open_with_trouble },
    },
  },
})

-- load extensions
local extensions_list = { 'fzy_native' }
for _, ext in ipairs(extensions_list) do
  telescope.load_extension(ext)
end
