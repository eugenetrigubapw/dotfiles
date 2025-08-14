vim.pack.add {
  {
    name = 'nvim-treesitter',
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
  {
    name = 'nvim-treesitter-context',
    src = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
  },
}

require 'nvim-treesitter'
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  auto_install = true,
  modules = {},
  sync_install = false,
  ignore_install = { 'norg', 'org', 'ipkg' }, -- Issues installing them, unused anyway.
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby', 'cpp' },
  },
  indent = { enable = true, disable = { 'ruby', 'cpp' } },
  incremental_selection = { enable = true },
  context_commentstring = { enable = true },
  textobjects = { enable = true },
}

local nts = require 'nvim-treesitter'
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == 'nvim-treesitter' and args.data.kind == 'update' then
      vim.schedule(function()
        nts.update()
      end)
    end
  end,
})
