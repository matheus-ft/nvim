require('lsp_signature').setup({
  toggle_key = '<A><S-k>', -- toggle signature on and off in insert mode
  select_signature_key = '<A-n>', -- cycle to next signature
  floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash

  bind = true, -- This is mandatory, otherwise border config won't get registered --- If you want to hook lspsaga or other signature handler, pls set to false
  handler_opts = {
    border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
  },
  transparency = 20, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 80, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window

  noice = false, -- set to true if you using noice to render markdown
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating

  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number
})
