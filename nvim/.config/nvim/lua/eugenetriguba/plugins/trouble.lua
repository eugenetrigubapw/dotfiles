vim.pack.add {
  {
    name = 'trouble.nvim',
    src = 'https://github.com/folke/trouble.nvim',
  },
}

require('trouble').setup {
  win = {
    size = 0.4,
  },
}

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set(
  'n',
  '<leader>xX',
  '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
  { desc = 'Buffer Diagnostics (Trouble)' }
)
vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set(
  'n',
  '<leader>xl',
  '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
  { desc = 'LSP Definitions / references / ... (Trouble)' }
)
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

vim.keymap.set('n', '[q', function()
  require('trouble').next { skip_groups = true, jump = true }
end, { desc = 'Next trouble item' })
vim.keymap.set('n', ']q', function()
  require('trouble').prev { skip_groups = true, jump = true }
end, { desc = 'Previous trouble item' })
