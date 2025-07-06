return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  config = function(_, opts)
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    require('oil').setup(opts)
  end,
  lazy = false,
}
