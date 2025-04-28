vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set
local telescope = require('telescope.builtin')

map('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })


map("n", "<leader>sh", ":split<CR>")
map("n", "<leader>sv", ":vsplit<CR>")

