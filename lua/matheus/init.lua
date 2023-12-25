M = {}

M.noremap = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc or opts.desc or ''
  opts.remap = false
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc or opts.desc or ''
  opts.remap = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.setup = function(table)
  require('matheus.options')
  require('matheus.keymaps')
  require('matheus.autocmds')
end

return M
