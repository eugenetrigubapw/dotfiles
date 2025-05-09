return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        size = 15,
        open_mapping = [[<C-\>]],
        shade_filetypes = {},
        shade_terminals = true,
        direction = 'horizontal',
      }
    end,
  },
}
