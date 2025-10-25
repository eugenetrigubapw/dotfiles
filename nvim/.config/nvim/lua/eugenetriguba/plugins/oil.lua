return {
  'https://github.com/stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { 'https://github.com/echasnovski/mini.icons', opts = {} } },
  config = function(_, opts)
    vim.keymap.set('n', '\\', '<CMD>Oil --float<CR>', { desc = 'Open parent directory in floating window' })
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    require('oil').setup {
      keymaps = {
        ['<C-l>'] = false,
        ['<C-h>'] = false,
        ['<C-r>'] = 'actions.refresh',
      },
    }
  end,
  lazy = false,
}
