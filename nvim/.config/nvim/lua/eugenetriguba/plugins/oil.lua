return {
  'https://github.com/stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ['<C-l>'] = false, -- Conflicts with tmux-navigator
    },
  },
  dependencies = { { 'https://github.com/echasnovski/mini.icons', opts = {} } },
  config = function(_, opts)
    vim.keymap.set('n', '\\', '<CMD>Oil --float<CR>', { desc = 'Open parent directory in floating window' })
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    require('oil').setup(opts)
  end,
  lazy = false,
}
