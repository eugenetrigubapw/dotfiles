vim.pack.add {
  {
    name = 'lazygit.nvim',
    src = 'https://github.com/kdheepak/lazygit.nvim',
  },
  {
    name = 'plenary.nvim',
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
}
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
