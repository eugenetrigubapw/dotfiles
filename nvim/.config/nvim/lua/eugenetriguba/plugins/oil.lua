-- Replace netrw with Oil to work with the file hierarchy as a regular
-- vim buffer.
vim.pack.add {
  {
    name = 'oil',
    src = 'https://github.com/stevearc/oil.nvim',
  },
  {
    name = 'mini.icons',
    src = 'https://github.com/nvim-mini/mini.icons',
  },
}
require('oil').setup {
  keymaps = {
    -- Clashes with tmux navigator
    ['<C-l>'] = false,
    ['<C-h>'] = false,
    ['<C-r>'] = 'actions.refresh',
  },
}
vim.keymap.set('n', '\\', '<CMD>Oil --float<CR>', { desc = 'Open parent directory in floating window' })
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
