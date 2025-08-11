-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set Python 3 to a virtual environment with `pynvim` installed
-- to support python plugins.
vim.g.python3_host_prog = vim.fn.expand '~/.config/nvim/venv/bin/python'

