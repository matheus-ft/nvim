local telescope = require('telescope')
local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')
local ok, wk = pcall(require, 'which-key')
local noremap = require('matheus').noremap
local silent = { silent = true }

if ok then
  wk.register({ ['<leader>p'] = 'Telescope' }, { mode = 'n' })
end

noremap('n', '<leader>pf', function()
  vim.cmd.Telescope('find_files')
end, 'Project files', silent)

noremap('n', '<leader>ps', function()
  vim.cmd.Telescope('live_grep')
end, 'Project search', silent)

noremap('n', '<leader>pb', function()
  vim.cmd.Telescope('buffers')
end, 'Project buffers', silent)

noremap('n', '<leader>h', function()
  vim.cmd.Telescope('help_tags')
end, 'Help tags', silent)

noremap('n', '<leader>pd', function()
  vim.cmd.Telescope('diagnostics')
end, 'Project diagnostics', silent)

noremap('n', '<leader>pt', vim.cmd.TodoTelescope, 'Project TODOs', silent)
noremap('n', '<leader>pp', vim.cmd.Telescope, 'Telescope', silent)

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
