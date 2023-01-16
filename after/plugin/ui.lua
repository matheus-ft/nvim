-------------------------------------------------------------------------------
-- Colorscheme
vim.cmd([[ syntax on ]])
vim.cmd([[ filetype plugin indent on ]])
local theme = require('matheus.themes.gruvbox')

-------------------------------------------------------------------------------
-- Indentation guides
vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#42464e' })
vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#5b606b' })
vim.api.nvim_set_hl(0, 'IndentBlanklineContextSpaceChar', { fg = '#42464e' })
vim.api.nvim_set_hl(0, 'IndentBlanklineSpaceChar', { fg = '#42464e' })

require('indent_blankline').setup({
  char = '▏',
  context_char = '▏',
  show_current_context = true,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
})

vim.opt.list = true
vim.opt.listchars:append('lead:⋅,tab:> ,trail: ') -- only shows leading spaces (amonst them, indentation)
vim.opt.fillchars = { foldopen = '', foldclose = '' }

-------------------------------------------------------------------------------
-- Other plugins
require('colorizer').setup({
  user_default_options = {
    names = false,
  },
})
require('numb').setup()
local notify = require('notify')
notify.setup({ background_colour = '#000000' })
vim.notify = notify

-------------------------------------------------------------------------------
-- Statusline
vim.opt.laststatus = 3 -- globalstatus for any bar
local ok, noice = pcall(require, 'noice')
local recording = nil
local search = nil
if ok then
  local noice_mode = noice.api.status.mode
  local noice_search = noice.api.status.search
  recording = { noice_mode.get, cond = noice_mode.has, color = { fg = '#ff9e64' } }
  search = { noice_search.get, cond = noice_search.has, color = { fg = '#5b606b' } }
end

require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    theme = theme,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'diff', 'filename', 'diagnostics' },
    lualine_x = { recording, search, 'encoding', 'fileformat' },
    lualine_y = { 'buffers' },
    lualine_z = { 'location' },
  },
  extensions = { 'nvim-tree' },
})

-------------------------------------------------------------------------------
-- NOICE!
if ok then
  local cmdline_float = true
  local cmdline_view = 'cmdline'
  local cmdline_opts = {}
  local popupmenu_opts = {}
  if cmdline_float then
    cmdline_view = cmdline_view .. '_popup'
    cmdline_opts = {
      position = {
        row = 0,
        col = '50%',
      },
      size = {
        width = 60,
        height = 'auto',
      },
    }
    popupmenu_opts = {
      relative = 'editor',
      position = {
        row = 4,
        col = cmdline_opts.position.col,
      },
      size = {
        width = cmdline_opts.size.width,
        height = 'auto',
        max_height = 10,
      },
      border = {
        style = 'rounded',
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = 'Normal', FloatBorder = 'NoiceCmdlinePopupBorder' },
      },
    }
  end

  noice.setup({
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
    },
    cmdline = {
      enabled = true, -- enables the Noice cmdline UI -- which provides a minor space gain at the bottom
      view = cmdline_view, -- view for rendering the cmdline -- options = 'cmdline' for bottom and 'cmdline_popup' for floating
      format = { -- to disable a format, set to `false`
        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        cmdline = { pattern = '^:', icon = ' ', lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = ' $', lang = 'bash' },
        lua = { pattern = '^:%s*lua%s+', icon = ' ', lang = 'lua' },
        help = { pattern = '^:%s*he?l?p?%s+', icon = ' ?' },
      },
    },
    messages = {
      enabled = true, -- enables the Noice messages UI -- and the cmdline automatically (they're linked)
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
      view_warn = 'notify', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
    popupmenu = {
      enabled = true, -- enables the Noice popupmenu UI
      backend = 'nui', -- backend to use to show regular cmdline completions
      kind_icons = require('matheus.lsp.kind'),
    },
    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify (fallsback to mini)
      -- Benefit of using Noice for this is the routing and consistent history view
      enabled = true,
      view = 'notify',
    },

    lsp = {
      progress = {
        enabled = false, -- disabled until it stops making the terminal tab name behave weirdly
        format = { -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          '({data.progress.percentage}%) ',
          { '{spinner} ', hl_group = 'NoiceLspProgressSpinner' },
          { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
          { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
        },
        format_done = 'lsp_progress_done',
        throttle = 1000 / 30, -- frequency to update lsp progress message
        view = 'mini',
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true, -- override the default lsp markdown formatter with Noice
        ['vim.lsp.util.stylize_markdown'] = true, -- override the lsp markdown formatter with Noice
        ['cmp.entry.get_documentation'] = true, -- override cmp documentation with Noice (needs the other options to work)
      },
      hover = {
        enabled = true, -- this looks really good
        view = nil, -- when nil, use defaults from documentation
        opts = {}, -- merged with defaults from documentation
      },
      signature = { enabled = false }, -- already using lsp_signature
      message = { -- Messages shown by lsp servers
        enabled = true,
        view = 'notify',
        opts = {},
      },
      documentation = { -- defaults for hover and signature help
        view = 'hover',
        opts = {
          lang = 'markdown',
          replace = true,
          render = 'plain',
          format = { '{message}' },
          win_options = { concealcursor = 'n', conceallevel = 3 },
        },
      },
    },

    health = { checker = true }, -- Disable if you don't want health checks to run ,
    smart_move = { -- noice tries to move out of the way of existing floating windows.
      enabled = true, -- you can disable this behaviour here
      -- add any filetypes here, that shouldn't trigger smart move.
      excluded_filetypes = { 'cmp_menu', 'cmp_docs', 'notify' },
    },
    throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.

    views = {
      cmdline_popup = cmdline_opts,
      popupmenu = popupmenu_opts,
    },
    routes = {
      { -- don't show 'buffer written' notifications
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
      { -- open long messages in split
        filter = { event = 'msg_show', min_height = 10 },
        view = 'cmdline_output',
      },
      { -- output to horizontal split instead of notification
        view = 'cmdline_output',
        filter = { cmdline = '^:' },
      },
    },
    status = {},
    format = {},
  })
end
