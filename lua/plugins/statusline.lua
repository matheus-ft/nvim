return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.opt.showmode = false
    vim.opt.laststatus = 3
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
        theme = 'onedark',
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
  end,
}
