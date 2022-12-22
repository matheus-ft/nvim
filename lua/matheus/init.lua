M = {}

local keybinding = function(mode, lhs, rhs, desc, opts)
  opts.buffer = opts.buffer or nil -- default is global
  opts.silent = opts.silent or false
  opts.nowait = opts.nowait or false
  opts.expr = opts.expr or false
  local ok, which_key = pcall(require, "which_key")
  if ok then
    opts.mode = mode
    which_key.register({ [lhs] = { rhs, desc } }, opts)
  else
    opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

M.noremap = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.remap = false
  desc = desc or opts.desc or ""
  keybinding(mode, lhs, rhs, desc, opts)
end

M.map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.remap = true
  desc = desc or opts.desc or ""
  keybinding(mode, lhs, rhs, desc, opts)
end

return M
