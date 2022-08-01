require('Comment').setup({
    mappings = {
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,

        extra = true,

        ---Disabled by default. Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = true,
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

    -- extended (examples from the readme)
    -- # Linewise
    -- gcw - Toggle from the current cursor position to the next word
    -- gc$ - Toggle from the current cursor position to the end of line
    -- gc} - Toggle until the next blank line
    -- gc5j - Toggle 5 lines after the current cursor position
    -- gc8k - Toggle 8 lines before the current cursor position
    -- gcip - Toggle inside of paragraph
    -- gca} - Toggle around curly brackets
    --
    -- # Blockwise
    -- gb2} - Toggle until the 2 next blank line
    -- gbaf - Toggle comment around a function (w/ LSP/treesitter support)
    -- gbac - Toggle comment around a class (w/ LSP/treesitter support)
})

