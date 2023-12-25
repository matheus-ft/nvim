local M = {}

M.setup = function(capabilities, on_attach)
  vim.cmd([[syntax on]])
  local lspconfig = require('lspconfig')
  local mason_lspconfig = require('mason-lspconfig')

  mason_lspconfig.setup({ -- this have to be done before any servers are set up
    ensure_installed = { 'lua_ls', 'bashls', 'pyright', 'marksman' },
    automatic_installtion = true,
  })

  mason_lspconfig.setup_handlers({ -- this sets up all installed servers
    function(server)
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  })

  -- got below from https://github.com/neovim/nvim-lspconfig/issues/319#issuecomment-1236123717
  local start_lua_ls = true
  local current_buf_id = vim.api.nvim_get_current_buf()
  local servers_attached_to_current_buf = vim.lsp.get_active_clients({ bufnr = current_buf_id })

  for _, server in ipairs(servers_attached_to_current_buf) do
    if server.name == 'lua_ls' then -- an instance of lua_ls is already attached to the buffer
      start_lua_ls = false
    end
  end

  if start_lua_ls then
    -- borrowed below from NvChad
    lspconfig['lua_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    })
  end
end

return M
