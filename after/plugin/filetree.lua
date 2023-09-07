require('nvim-tree').setup({
  hijack_cursor = true,
  update_focused_file = { enable = true },

  view = {
    adaptive_size = true,
    signcolumn = 'auto',
  },

  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_opened_files = 'all',
    special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },

    indent_markers = {
      enable = true,
      icons = {
        corner = '└ ',
        edge = '│ ',
        item = '│ ',
        none = '  ',
      },
    },

    icons = {
      git_placement = 'after',
      glyphs = {
        default = '',
        symlink = '',
        bookmark = '',
        folder = {
          arrow_closed = '',
          arrow_open = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },

  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },

  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
})

require('matheus').noremap('n', '<leader>t', vim.cmd.NvimTreeToggle, 'Filetree', { silent = true })
