vim.pack.add {
  { name = 'lazygit.nvim', src = 'https://github.com/kdheepak/lazygit.nvim' },
  { name = 'plenary.nvim', src = 'https://github.com/nvim-lua/plenary.nvim' },
}

vim.api.nvim_create_user_command('LazyGit', function()
  require('lazygit').lazygit()
end, {})

vim.api.nvim_create_user_command('LazyGitConfig', function()
  require('lazygit').lazygit_config()
end, {})

vim.api.nvim_create_user_command('LazyGitCurrentFile', function()
  require('lazygit').lazygit_current_file()
end, {})

vim.api.nvim_create_user_command('LazyGitFilter', function()
  require('lazygit').lazygit_filter()
end, {})

vim.api.nvim_create_user_command('LazyGitFilterCurrentFile', function()
  require('lazygit').lazygit_filter_current_file()
end, {})

vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
