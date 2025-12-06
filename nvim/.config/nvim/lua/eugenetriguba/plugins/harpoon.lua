vim.pack.add {
  {
    name = 'harpoon',
    src = 'https://github.com/ThePrimeagen/harpoon',
    version = 'harpoon2',
  },
  {
    name = 'plenary.nvim',
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
}
local harpoon = require 'harpoon'
harpoon:setup()
vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<leader>1', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<leader>2', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<leader>3', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<leader>4', function()
  harpoon:list():select(4)
end)

vim.keymap.set('n', '<C-x>', function()
  harpoon:list():clear()
end, { desc = 'Clear Harpoon list' })
vim.keymap.set('n', '<leader>hp', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<leader>hn', function()
  harpoon:list():next()
end)
