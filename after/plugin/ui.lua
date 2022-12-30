-------------------------------------------------------------------------------
-- Colorscheme
vim.cmd([[ syntax on ]])
vim.cmd([[ filetype plugin indent on ]])
local theme = require('matheus.themes.onedark')

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

-------------------------------------------------------------------------------
-- Other plugins
require('colorizer').setup()
require('numb').setup()
local notify = require('notify')
notify.setup({ background_colour = '#000000' })
vim.notify = notify

-------------------------------------------------------------------------------
-- Statusline
vim.opt.laststatus = 3 -- globalstatus for any bar
local ok, noice = pcall(require, 'noice')
local recording = nil
if ok then
  local noice_mode = noice.api.statusline.mode
  recording = { noice_mode.get, cond = noice_mode.has, color = { fg = '#ff9e64' } }
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
    lualine_x = { recording, 'encoding', 'fileformat' },
    lualine_y = { 'buffers' },
    lualine_z = { 'location' },
  },
  extensions = { 'nvim-tree' },
})

-------------------------------------------------------------------------------
-- NOICE
if ok then
  noice.setup({
    cmdline = {
      enabled = true, -- enables the Noice cmdline UI -- provides a minor space gain at the bottom
      view = 'cmdline_popup', -- view for rendering the cmdline -- options = 'cmdline' for bottom and 'cmdline_popup' for floating
      opts = {}, -- global options for the cmdline. See section on views
      ---@type table<string, CmdlineFormat>
      format = {
        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        cmdline = { pattern = '^:', icon = '', lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
        lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
        help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
        input = {}, -- Used by input()
        -- lua = false, -- to disable a format, set to `false`
      },
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
      view_warn = 'notify', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
    popupmenu = {
      enabled = true, -- enables the Noice popupmenu UI
      ---@type 'nui'|'cmp'
      backend = 'nui', -- backend to use to show regular cmdline completions
      ---@type NoicePopupmenuItemKind|false
      -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
      kind_icons = {}, -- set to `false` to disable icons
    },
    -- default options for require('noice').redirect
    -- see the section on Command Redirection
    ---@type NoiceRouteConfig
    redirect = {
      view = 'popup',
      filter = { event = 'msg_show' },
    },
    -- You can add any custom commands below that will be available with `:Noice command`
    ---@type table<string, NoiceCommand>
    commands = {
      history = {
        -- options for the message history that you get with `:Noice`
        view = 'split',
        opts = { enter = true, format = 'details' },
        filter = {
          any = {
            { event = 'notify' },
            { error = true },
            { warning = true },
            { event = 'msg_show', kind = { '' } },
            { event = 'lsp', kind = 'message' },
          },
        },
      },
      -- :Noice last
      last = {
        view = 'popup',
        opts = { enter = true, format = 'details' },
        filter = {
          any = {
            { event = 'notify' },
            { error = true },
            { warning = true },
            { event = 'msg_show', kind = { '' } },
            { event = 'lsp', kind = 'message' },
          },
        },
        filter_opts = { count = 1 },
      },
      -- :Noice errors
      errors = {
        -- options for the message history that you get with `:Noice`
        view = 'popup',
        opts = { enter = true, format = 'details' },
        filter = { error = true },
        filter_opts = { reverse = true },
      },
    },
    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify
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
        enabled = true,
        view = nil, -- when nil, use defaults from documentation
        opts = {}, -- merged with defaults from documentation
      },
      signature = {
        enabled = false,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
        view = nil, -- when nil, use defaults from documentation
        opts = {}, -- merged with defaults from documentation
      },
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = 'notify',
        opts = {},
      },
      -- defaults for hover and signature help
      documentation = {
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

    markdown = {
      hover = {
        ['|(%S-)|'] = vim.cmd.help, -- vim help links
        ['%[.-%]%((%S-)%)'] = require('noice.util').open, -- markdown links
      },
      highlights = {
        ['|%S-|'] = '@text.reference',
        ['@%S+'] = '@parameter',
        ['^%s*(Parameters:)'] = '@text.title',
        ['^%s*(Return:)'] = '@text.title',
        ['^%s*(See also:)'] = '@text.title',
        ['{%S-}'] = '@parameter',
      },
    },
    health = {
      checker = true, -- Disable if you don't want health checks to run
    },
    smart_move = {
      -- noice tries to move out of the way of existing floating windows.
      enabled = true, -- you can disable this behaviour here
      -- add any filetypes here, that shouldn't trigger smart move.
      excluded_filetypes = { 'cmp_menu', 'cmp_docs', 'notify' },
    },
    ---@type NoicePresets
    presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    ---@type NoiceConfigViews
    views = {}, ---@see section on views
    ---@type NoiceRouteConfig[]
    routes = {}, --- @see section on routes
    ---@type table<string, NoiceFilter>
    status = {}, --- @see section on statusline components
    ---@type NoiceFormatOptions
    format = {}, --- @see section on formatting
  })
end
