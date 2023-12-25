local noremap = require('matheus').noremap

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter', -- lazy loading
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'lukas-reineke/cmp-under-comparator',
      { 'kkoomen/vim-doge', build = ':call doge#install()' },
    },
    config = function()
      vim.opt.completeopt:append({ 'menu', 'menuone', 'noselect' })
      local cmp = require('cmp')
      local lspkind = require('matheus.lsp.kind')

      -- borrowed from NvChad
      local function border(hl_name)
        return {
          { '╭', hl_name },
          { '─', hl_name },
          { '╮', hl_name },
          { '│', hl_name },
          { '╯', hl_name },
          { '─', hl_name },
          { '╰', hl_name },
          { '│', hl_name },
        }
      end

      -- If you want insert `(` after select function or method item
      local ok, autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
      if ok then
        cmp.event:on('confirm_done', autopairs.on_confirm_done())
      end

      cmp.setup({
        window = {
          completion = {
            border = border('CmpBorder'),
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
          },
          documentation = { border = border('CmpDocBorder') },
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- default vim behavior
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- default vim behavior
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert, select = true }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert, select = true }),
          ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }), -- accept the explicitly selected item
          ['<C-y>'] = cmp.mapping( -- borrowed from Teej
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }),
            { 'i', 'c' }
          ),
          ['<C-e>'] = cmp.mapping.abort(),
        },
        sources = { -- in order of priority
          { name = 'nvim_lua' }, -- only works for lua, so won't fuck up the priority
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'luasnip' },
          { name = 'buffer', keyword_length = 3 },
        },
        snippet = { -- to get snippets enabled
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        experimental = {
          native_menu = false,
          ghost_text = true,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require('cmp-under-comparator').under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', lspkind[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
              buffer = '[Buffer]',
              nvim_lsp = '[LSP]',
              luasnip = '[Snip]',
              nvim_lua = '[Lua]',
              latex_symbols = '[LaTeX]',
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- snippets
      require('luasnip.loaders.from_vscode').lazy_load() -- funny, huh?

      -- doc generator
      noremap('n', '<leader>d', '<nop>', 'Diagnostics')
      noremap('n', '<leader>i', '<Plug>(doge-generate)', 'Insert documentation')
      vim.g.doge_comment_jump_modes = { 'n', 's' } -- removing i to use tab-completion
      vim.g.doge_doc_standard_python = 'numpy'
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' }, -- lazy loading
    dependencies = {
      'williamboman/mason-lspconfig.nvim', -- for server management

      'hrsh7th/cmp-nvim-lsp', -- to use the autocompletion
      'ray-x/lsp_signature.nvim', -- adds function signature helper pop-up

      'nvimdev/lspsaga.nvim', -- improves lsp actions
      'rmagatti/goto-preview', -- opens definitions/declarations/etc in a pop-up window
      'RRethy/vim-illuminate', -- highlights same words in scope

      'folke/trouble.nvim', -- lists problems like most IDEs
      'folke/todo-comments.nvim', -- similar to trouble but for TODOs

      'mhartington/formatter.nvim',
    },
    config = function()
      local ok, wk = pcall(require, 'which-key')
      local illuminate = require('illuminate')
      local saga = require('matheus.lsp.saga')
      local preview = require('matheus.lsp.preview')
      local trouble = require('matheus.lsp.trouble')
      local todo = require('matheus.lsp.todo')
      local formatter = require('matheus.lsp.formatter')
      require('matheus.lsp.signature')

      local on_attach = function(client, bufnr)
        illuminate.on_attach(client)

        -- Mappings
        local lsp = vim.lsp.buf
        local bufopts = { silent = true, buffer = bufnr }

        noremap('n', '<A-n>', function()
          illuminate.next_reference({ wrap = true })
        end, 'Jump to next occurance', bufopts)
        noremap('n', '<A-N>', function()
          illuminate.next_reference({ reverse = true, wrap = true })
        end, 'Jump to previous occurance', bufopts)

        noremap('n', 'gD', lsp.declaration, 'Go to declaration', bufopts)
        noremap('n', 'gd', lsp.definition, 'Go to definition', bufopts)
        noremap('n', 'gt', lsp.type_definition, 'Go to type-definition', bufopts)
        noremap('n', 'gi', lsp.implementation, 'Go to implementation', bufopts)
        noremap('n', 'gr', lsp.references, 'Open references', bufopts)
        noremap('n', 'gR', trouble.lsp.references, 'Go to references', bufopts)

        if ok then
          wk.register({ ['gp'] = 'Go to preview' }, { mode = 'n' })
        end
        noremap('n', 'gpd', saga.lsp.preview_definition, 'Preview definition', bufopts)
        noremap('n', 'gpt', preview.goto_preview_type_definition, 'Preview type-def', bufopts)
        noremap('n', 'gpi', preview.goto_preview_implementation, 'Preview implementation', bufopts)
        noremap('n', 'gpr', preview.goto_preview_references, 'Preview references in Telescope', bufopts)

        noremap('n', 'go', saga.lsp.finder, 'Find all occurances', bufopts)
        noremap('n', 'K', lsp.hover, 'Hover docs', bufopts)
        noremap('n', '<A-f>', formatter.apply, 'Format file', bufopts)
        noremap('n', '<leader>r', saga.lsp.rename, 'Rename symbol', bufopts)
        noremap({ 'n', 'v' }, '<leader>ca', saga.lsp.code_action, 'Code actions', bufopts)

        if ok then
          wk.register({ ['<leader>d'] = 'Diagnostics' }, { mode = 'n' })
        end
        noremap('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic', bufopts)
        noremap('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic', bufopts)
        noremap('n', ']t', todo.jump_next, 'Next todo comment', bufopts)
        noremap('n', '[t', todo.jump_prev, 'Previous todo comment', bufopts)
        noremap('n', '<leader>dt', vim.cmd.TodoTrouble, 'TODOs', bufopts)
        noremap('n', '<leader>dl', vim.cmd.TroubleToggle, 'List diagnostics', bufopts)
        noremap('n', '<leader>dw', trouble.lsp.workspace_diagnostics, 'Workspace diagnostics', bufopts)
        noremap('n', '<leader>df', trouble.lsp.document_diagnostics, 'File diagnostics', bufopts)
      end
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      require('matheus.lsp.languages').setup(capabilities, on_attach)
    end,
  },
}
