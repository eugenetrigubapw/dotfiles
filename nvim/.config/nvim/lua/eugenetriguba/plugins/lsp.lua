vim.pack.add {
  {
    name = 'lazydev.nvim',
    src = 'https://github.com/folke/lazydev.nvim',
  },
  {
    name = 'nvim-lspconfig',
    src = 'https://github.com/neovim/nvim-lspconfig',
  },
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
    name = 'fidget.nvim',
    src = 'https://github.com/j-hui/fidget.nvim',
  },
}

-- Lazydev for Lua development
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}
-- Fidget for LSP progress
require('fidget').setup {}
require('mason').setup()
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local fzf = require 'fzf-lua'
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grr', fzf.lsp_references, '[G]oto [R]eferences')
    map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')
    map('grd', fzf.lsp_definitions, '[G]oto [D]efinition')
    map('grD', fzf.lsp_declarations, '[G]oto [D]eclaration')
    map('gO', fzf.lsp_document_symbols, 'Open Document Symbols')
    map('gW', fzf.lsp_workspace_symbols, 'Open Workspace Symbols')
    map('grt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}

local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
  clangd = {},
  gopls = {},
  basedpyright = {
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          typeCheckingMode = 'basic',
        },
      },
    },
  },
  rust_analyzer = {},
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
  stylua = {},
  tailwindcss = {},
  mesonlsp = {},
  terraformls = {},
  bashls = {},
  jdtls = {
    settings = {
      java = {
        configuration = {
          updateBuildConfiguration = 'interactive',
          refreshBundles = true,
        },
        completion = {
          favoriteStaticMembers = {
            'org.hamcrest.MatcherAssert.assertThat',
            'org.hamcrest.Matchers.*',
            'org.hamcrest.CoreMatchers.*',
            'org.junit.jupiter.api.Assertions.*',
            'java.util.Objects.requireNonNull',
            'java.util.Objects.requireNonNullElse',
          },
        },
        contentProvider = { preferred = 'fernflower' },
        eclipse = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = 'all',
          },
        },
        maven = {
          downloadSources = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        saveActions = {
          organizeImports = true,
        },
        signatureHelp = { enabled = true },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
      },
    },
  },
}

local ensure_installed = vim.tbl_keys(servers or {})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }
require('mason-lspconfig').setup {
  ensure_installed = {},
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
