-- [[ Setting options ]]
--  See `:help vim.opt`
--  For more options, see `:help option-list`
local opt = vim.opt

-- Make line numbers default
opt.number = true

-- Use relative line numbers, to help with jumping.
opt.relativenumber = true

-- In Insert mode, replace <Tab> with the appropriate
-- number of spaces.
opt.expandtab = true

-- When starting a new line, use smart indentation to
-- figure out what indentation the new line should be
-- at.
opt.autoindent = true
opt.smartindent = true

-- Number of spaces to use for each step of autoindentation.
opt.shiftwidth = 2

-- Number of spaces to use when using <Tab>.
opt.tabstop = 2

-- Case-insensitive searching UNLESS \C or one
-- or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Explicitly enable 24-bit RGB colors in the terminal.
-- Neovim will normally automatically attempt to enable
-- this if it detects the terminal can support it.
opt.termguicolors = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Show which line your cursor is on
opt.cursorline = true

-- If performing an operation that would fail due to unsaved
-- changes in the buffer (like `:q`), instead raise a dialog
-- asking if you wish to save the current file(s)
--
-- See `:help 'confirm'`
opt.confirm = true

-- Save undo history
opt.undofile = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Enable mouse mode e.g. can be useful for resizing splits
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--
-- Schedule the setting after `UiEnter` because it can increase
-- startup-time. Remove this option to keep the OS clipboard
-- independent from neovim.
--
-- See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Continue to visually indent wrapped lines
-- to preserve horizontal blocks of text
opt.breakindent = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- See `:help 'list'` and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

opt.spellfile = vim.fn.stdpath 'config' .. '/spell/en.utf-8.add'
