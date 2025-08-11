vim.pack.add {
  {
    name = 'oil',
    src = 'https://github.com/stevearc/oil.nvim',
  },
  {
    name = 'mini.icons',
    src = 'https://github.com/echasnovski/mini.icons',
  },
}

require('oil').setup {
  keymaps = {
    ['<C-l>'] = false, -- Clashes with tmux navigator
  },
}
vim.keymap.set('n', '\\', '<CMD>Oil --float<CR>', { desc = 'Open parent directory in floating window' })
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
