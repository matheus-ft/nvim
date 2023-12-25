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
})

M = {}

M.apply = function()
  return vim.cmd.FormatLock()
end

return M
