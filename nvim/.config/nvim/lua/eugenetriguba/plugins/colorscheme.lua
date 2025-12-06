vim.pack.add {
  {
    name = 'tokyonight',
    src = 'https://github.com/folke/tokyonight.nvim',
  },
}
require('tokyonight').setup {
  styles = {
    comments = { italic = false },
  },
}
vim.cmd.colorscheme 'tokyonight'
