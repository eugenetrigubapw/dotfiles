vim.pack.add {
  {
    name = 'blink.cmp',
    src = 'https://github.com/saghen/blink.cmp',
  },
  {
    name = 'LuaSnip',
    src = 'https://github.com/L3MON4D3/LuaSnip',
  },
  {
    name = 'friendly-snippets',
    src = 'https://github.com/rafamadriz/friendly-snippets',
  },
  {
    name = 'lazydev.nvim',
    src = 'https://github.com/folke/lazydev.nvim',
  },
}

local lsp = vim.api.nvim_create_augroup('lsp', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Setup lua lsp on lua filetype',
  pattern = 'lua',
  group = lsp,
  callback = function()
    require('lazydev').setup {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    }
  end,
})

require('luasnip').setup {}
require('luasnip.loaders.from_vscode').lazy_load() -- load friendly-snippets

require('blink.cmp').setup {
  keymap = {
    preset = 'default',
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },

  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'lazydev',
    },
    providers = {
      lazydev = {
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
}

vim.api.nvim_create_user_command('BlinkBuild', function()
  local utils = require 'eugenetriguba.utils'
  local blink_path = vim.fn.stdpath 'data' .. '/site/pack/core/opt/blink.cmp'
  utils.build_with_job({ 'cargo', '+nightly', 'build', '--release' }, blink_path, 'blink.cmp')
end, { desc = 'Build blink.cmp' })

vim.api.nvim_create_user_command('LuaSnipBuild', function()
  if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
    vim.notify 'LuaSnip build not supported on this system'
    return
  end
  local utils = require 'eugenetriguba.utils'
  local luasnip_path = vim.fn.stdpath 'data' .. '/site/pack/core/opt/LuaSnip'
  utils.build_with_job({ 'make', 'install_jsregexp' }, luasnip_path, 'LuaSnip')
end, { desc = 'Build LuaSnip jsregexp' })
