require('Comment').setup({
  mappings = {
    ---Operator-pending mapping
    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,

    extra = true,
  },

  ---LHS of toggle mappings in NORMAL + VISUAL mode
  toggler = {
    ---Line-comment toggle keymap
    line = 'gcc',
    ---Block-comment toggle keymap
    block = 'gbc',
  },

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = 'gc',
    ---Block-comment keymap
    block = 'gb',
  },

  ---LHS of the extra mappings
  extra = {
    ---Add comment on the line above
    above = 'gcO',
    ---Add comment on the line below
    below = 'gco',
    ---Add comment at the end of line
    eol = 'gcA',
  },
})

local api = require('Comment.api')
local map = vim.keymap.set
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

map('n', 'g>', api.call('comment.linewise', 'g@'), { expr = true, desc = 'Comment region linewise' })
map('n', 'g>c', api.call('comment.linewise.current', 'g@$'), { expr = true, desc = 'Comment current line' })
map('n', 'g>b', api.call('comment.blockwise.current', 'g@$'), { expr = true, desc = 'Comment current block' })

map('n', 'g<', api.call('uncomment.linewise', 'g@'), { expr = true, desc = 'Uncomment region linewise' })
map('n', 'g<c', api.call('uncomment.linewise.current', 'g@$'), { expr = true, desc = 'Uncomment current line' })
map('n', 'g<b', api.call('uncomment.blockwise.current', 'g@$'), { expr = true, desc = 'Uncomment current block' })

map('x', 'g>', function(vim)
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.locked('comment.linewise')(vim.fn.visualmode())
end, { desc = 'Comment region linewise (visual)' })

map('x', 'g<', function(vim)
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.locked('uncomment.linewise')(vim.fn.visualmode())
end, { desc = 'Uncomment region linewise (visual)' })
