-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set Python 3 to a virtual environment with `pynvim` installed
-- to support python plugins.
vim.g.python3_host_prog = vim.fn.expand '~/.config/nvim/venv/bin/python'
