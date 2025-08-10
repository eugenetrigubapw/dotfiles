vim.pack.add {
  {
    name = 'mason.nvim',
    src = 'https://github.com/williamboman/mason.nvim',
  },
  {
    name = 'mason-lspconfig.nvim',
    src = 'https://github.com/williamboman/mason-lspconfig.nvim',
  },
  {
    name = 'mason-tool-installer.nvim',
    src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  {
    name = 'blink.cmp',
    src = 'https://github.com/saghen/blink.cmp',
  },
}

require('mason').setup {}

local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  -- Note: https://github.com/pmizio/typescript-tools.nvim may be a better
  -- LSP to use here at some point.
  ts_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  tailwindcss = {},
  mesonlsp = {},
  terraformls = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
  ensure_installed = {}, -- Populated via mason-tool-installer
  automatic_installation = false,
  automatic_enable = true,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}
