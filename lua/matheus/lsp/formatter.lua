local autocmd = vim.api.nvim_create_autocmd
local FORMATTER = vim.api.nvim_create_augroup('FORMATTER', { clear = true })
autocmd('BufWritePost', { pattern = '*', command = 'FormatWrite', group = FORMATTER }) -- formatting on write

local function formatters_for(ft)
  return require('formatter.filetypes.' .. ft)
end

local python = formatters_for('python')
local lua = formatters_for('lua')
local markdown = formatters_for('markdown')

require('formatter').setup({ -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
  filetype = {
    lua = { lua.stylua },
    python = { python.black, python.docformatter },
    markdown = { markdown.prettier },
  },

  -- EXAMPLE
  -- {
  --   -- Formatter configurations for filetype "lua" go here
  --   -- and will be executed in order
  --   lua = {
  --     -- "formatter.filetypes.lua" defines default configurations for the
  --     -- "lua" filetype
  --     require("formatter.filetypes.lua").stylua,
  --
  --     -- You can also define your own configuration
  --     function()
  --       local util = require('formatter.util') -- Utilities for creating configurations
  --       -- Supports conditional formatting
  --       if util.get_current_buffer_file_name() == "special.lua" then
  --         return nil
  --       end
  --
  --       -- Full specification of configurations is down below and in Vim help
  --       -- files
  --       return {
  --         exe = "stylua",
  --         args = {
  --           "--search-parent-directories",
  --           "--stdin-filepath",
  --           util.escape_path(util.get_current_buffer_file_path()),
  --           "--",
  --           "-",
  --         },
  --         stdin = true,
  --       }
  --     end
  --   },
  --
  --   -- Use the special "*" filetype for defining formatter configurations on
  --   -- any filetype
  --   ["*"] = {
  --     -- "formatter.filetypes.any" defines default configurations for any
  --     -- filetype
  --     require("formatter.filetypes.any").remove_trailing_whitespace
  --   }
  -- }
})
