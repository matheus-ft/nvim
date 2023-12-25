return {
  'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
  event = { 'BufReadPre', 'BufNewFile' }, -- lazy loading
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects', -- Additional text objects
    'm-demare/hlargs.nvim',
  },
  build = ':TSUpdate',
  config = function()
    require('hlargs').setup()
    vim.cmd([[syntax on]])
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'vim', 'vimdoc', 'lua', 'bash', 'python', 'markdown', 'markdown_inline' },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- grabbed everything below from kickstart.nvim
      indent = { enable = true, disable = { 'python' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<c-backspace>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    })
  end,
}