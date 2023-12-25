return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzy-native.nvim', -- sorts the findings
    'nvim-telescope/telescope-file-browser.nvim',
  },
  version = false, -- telescope did only one release, so use HEAD for now
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local noremap = require('matheus').noremap
    local silent = { silent = true }

    local ok, wk = pcall(require, 'which-key')
    if ok then
      wk.register({ ['<leader>p'] = 'Telescope' }, { mode = 'n' })
    end

    noremap('n', '<leader>pp', vim.cmd.Telescope, 'Telescope', silent)
    noremap('n', '<leader>ps', function()
      vim.cmd.Telescope('live_grep')
    end, 'Project search', silent)
    noremap('n', '<leader>pb', function()
      vim.cmd.Telescope('file_browser')
    end, 'Project browser', silent)
    noremap('n', '<leader>pf', function()
      vim.cmd.Telescope('find_files')
    end, 'Project files', silent)
    noremap('n', '<A-e>', function()
      vim.cmd.Telescope('find_files')
    end, 'Edit buffer', silent)
    noremap('n', '<A-b>', function()
      vim.cmd.Telescope('buffers')
    end, 'Project buffers', silent)
    noremap('n', '<leader>h', function()
      vim.cmd.Telescope('help_tags')
    end, 'Help tags', silent)
    noremap('n', '<leader>pd', function()
      vim.cmd.Telescope('diagnostics')
    end, 'Project diagnostics', silent)

    local ok, todo = pcall(require, 'folke/todo-comments.nvim')
    if ok then
      noremap('n', '<leader>pt', vim.cmd.TodoTelescope, 'Project TODOs', silent)
    end

    local ok, trouble = pcall(require, 'trouble.providers.telescope')
    local additioanl_maps = {}
    if ok then
      additional_maps = {
        n = {
          ['q'] = actions.close,
          ['<c-t>'] = trouble.open_with_trouble,
        },
        i = { ['<c-t>'] = trouble.open_with_trouble },
      }
    else
      additional_maps = {
        n = { ['q'] = actions.close },
      }
    end
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
        mappings = additional_maps,
      },
    })

    -- load extensions
    local extensions_list = { 'fzy_native', 'file_browser' }
    for _, ext in ipairs(extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
