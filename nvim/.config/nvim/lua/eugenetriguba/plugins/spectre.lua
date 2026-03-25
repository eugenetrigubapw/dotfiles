vim.pack.add {
  {
    name = 'nvim-spectre',
    src = 'https://github.com/nvim-pack/nvim-spectre',
  },
  {
    name = 'plenary.nvim',
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
}

vim.keymap.set('n', '<leader>ts', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = '[T]oggle [S]pectre',
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = '[S]earch current [w]ord',
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = '[S]earch current [w]ord',
})
vim.keymap.set('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = '[S]earch on current [f]ile',
})
