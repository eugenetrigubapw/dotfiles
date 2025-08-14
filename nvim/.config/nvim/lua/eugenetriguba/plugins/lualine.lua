return {
  {
    'https://github.com/nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'tokyonight',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
      },
    },
  },
}
