-- Treesitter adds understanding of the source code text (e.g. fields, methods,
-- classes)
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
local treesitter = require 'nvim-treesitter'
treesitter.setup {
  ensure_installed = 'all',
  auto_install = true,
  modules = {},
  sync_install = false,
  ignore_install = { 'norg', 'org', 'ipkg', 'verilog' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby', 'cpp' },
  },
  indent = { enable = true, disable = { 'ruby', 'cpp' } },
  incremental_selection = { enable = true },
  context_commentstring = { enable = true },
  textobjects = { enable = true },
}
require('treesitter-context').setup {
  multiline_threshold = 10,
}
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == 'nvim-treesitter' and (kind == 'update' or kind == 'install') then
      vim.schedule(function()
        -- If nvim-treesitter was updated, run ':TSUpdate' via the lua API to
        -- ensure the installed parsers are also updated.
        vim.cmd 'TSUpdate all'
      end)
    end
  end,
})
