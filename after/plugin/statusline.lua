vim.opt.laststatus = 3 -- globalstatus for any status bar

require('lualine').setup {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },

  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },

  extensions = {'fugitive', 'nvim-tree'}
}

vim.opt.termguicolors = true

require('bufferline').setup {
  options = {
    close_command = 'bdelete %d',
    right_mouse_command = 'write', -- saves the clicked buffer inplace
    left_mouse_command = 'buffer %d',
    middle_mouse_command = nil,

    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match('error') and ' ' or ''
        return icon .. count
    end,

    offsets = {{filetype = 'NvimTree', text = 'File Tree', text_align = 'center'}},
    show_close_icon = false, -- removes an useless icon in the right corner of the line
    separator_style = 'slant',
  }
}

