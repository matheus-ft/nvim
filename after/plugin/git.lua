vim.opt.signcolumn = 'yes' -- kinda weird this is not a boolean for neovim, but okay

require('gitsigns').setup({
  signs = {
    add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    untracked = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  },
  numhl = true,

  current_line_blame = true,
  current_line_blame_opts = {
    delay = 0,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '  <author>, <author_time:%Y-%m-%d> - <summary>',

  update_debounce = 100,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local noremap = require('matheus').noremap
    local ok, wk = pcall(require, 'which-key')
    local opts = { buffer = bufnr }

    if ok then
      wk.register({ ['<leader>g'] = 'Git' }, { mode = 'n' })
    end

    -- Actions
    noremap('n', '<leader>gA', gs.stage_buffer, 'Add/Stage buffer', opts)
    noremap('n', '<leader>gR', gs.reset_buffer, 'Restore buffer', opts)
    noremap({ 'n', 'v' }, '<leader>ga', ':Gitsigns stage_hunk<CR>', 'Add/Stage hunk', opts)
    noremap({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Restore hunk', opts)
    noremap('n', '<leader>gu', gs.undo_stage_hunk, 'Unstage hunk', opts)
    noremap('n', '<leader>gd', gs.preview_hunk, 'Preview diff', opts)
    noremap('n', '<leader>gb', gs.toggle_current_line_blame, 'Toggle line blame', opts)
    noremap('n', '<leader>gt', gs.toggle_deleted, 'Toggle deleted', opts)
    noremap('n', '<leader>gc', ':Git ', 'Commands', opts)
    noremap('n', '<leader>gs', vim.cmd.Git, 'Status', opts)
    noremap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git hunk', opts)
    noremap('n', '<leader>gD', vim.cmd.DiffviewOpen, 'Open diff buffer', opts)
    noremap('n', '<leader>gm', '<Plug>(git-messenger)', 'Open last message', opts)
    noremap('n', '<A-z>', ':Git checkout ', 'Change branch', opts)
    noremap('n', ']g', gs.next_hunk, 'Next git hunk', opts)
    noremap('n', '[g', gs.prev_hunk, 'Previous git hunk', opts)
  end,
})
