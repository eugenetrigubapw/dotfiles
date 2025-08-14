return {
  {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
    main = 'nvim-treesitter.configs',
    build = ':TSUpdate',
    opts = {
      ensure_installed = 'all',
      auto_install = true,
      ignore_install = { 'norg', 'org', 'ipkg' }, -- Issues installing them, unused anyway.
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby', 'cpp' },
      },
      indent = { enable = true, disable = { 'ruby', 'cpp' } },
      incremental_selection = { enable = true },
      context_commentstring = { enable = true },
      textobjects = { enable = true },
    },
  },
  {
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
  },
}
