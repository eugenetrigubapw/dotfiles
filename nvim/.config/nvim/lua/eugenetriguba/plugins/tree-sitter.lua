vim.pack.add {
  {
    name = 'nvim-treesitter',
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
  },
}

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

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.cmd 'TSUpdate'
  end,
})
