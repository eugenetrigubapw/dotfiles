vim.pack.add {
  {
    name = 'blink.cmp',
    src = 'https://github.com/saghen/blink.cmp',
    version = 'v1.8.0',
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
  {
    name = 'blink-cmp-copilot',
    src = 'https://github.com/giuxtaposition/blink-cmp-copilot',
  },
}
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'blink.cmp' then
      if args.data.kind == 'install' or args.data.kind == 'update' then
        vim.notify('Building blink.cmp...', vim.log.levels.INFO)
        vim.system({ 'cargo', '+nightly', 'build', '--release' }, { cwd = spec.path, text = true }, function(result)
          if result.code == 0 then
            vim.notify('blink.cmp build successful!', vim.log.levels.INFO)
          else
            vim.notify('blink.cmp build failed: ' .. (result.stderr or ''), vim.log.levels.ERROR)
          end
        end)
      end
    end
  end,
})
require('luasnip.loaders.from_vscode').lazy_load()
require('blink.cmp').setup {
  keymap = {
    preset = 'default',
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'copilot' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      copilot = {
        name = 'copilot',
        module = 'blink-cmp-copilot',
        score_offset = 100,
        async = true,
      },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
}
