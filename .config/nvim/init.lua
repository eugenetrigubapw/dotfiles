-- Flash screen instead of beep sound
vim.opt.visualbell = true
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.shiftwidth = 4
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.cmd('filetype plugin indent on')

-- Whitespace settings per filetype
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  command = 'setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.go',
  command = 'setlocal noet tabstop=4 shiftwidth=4 softtabstop=4'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'javascript', 'typescript', 'java', 'rust', 'c', 'cpp'},
  command = 'setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2'
})

-- Automatically install packer.nvim if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand to reload Neovim whenever you save the init.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Plugin manager setup using packer.nvim
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Auto complete
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Fuzzy finder
  use { 'junegunn/fzf', run = 'fzf#install()' }
  use 'junegunn/fzf.vim'

  -- Git gutter
  use 'airblade/vim-gitgutter'

  -- Status bar
  use 'nvim-lualine/lualine.nvim'

  -- Git wrapper with :G
  use 'tpope/vim-fugitive'

  -- Editorconfig file support
  use 'editorconfig/editorconfig-vim'

  -- Theme
  use 'sainnhe/everforest'

  -- Go support
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

  -- Treesitter for better syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'

  -- LSP Installer
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Setup LSP for C/C++ with clangd
local status_ok_mason, mason = pcall(require, "mason")
if status_ok_mason then
  mason.setup()
end

local status_ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if status_ok_mason_lspconfig then
  mason_lspconfig.setup()
end

local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if status_ok_lspconfig then
  lspconfig.clangd.setup{}
end

-- Treesitter setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "cpp", "go", "python", "javascript", "typescript", "java", "rust"
  },
  highlight = {
    enable = true,
  },
}

-- Lualine setup
require('lualine').setup {
  options = {
    theme = 'everforest',
    section_separators = {'', ''},
    component_separators = {'', ''},
  }
}

-- Nvim-tree setup
require'nvim-tree'.setup {}

-- Theme setup
vim.opt.termguicolors = true
vim.g.everforest_background = 'soft'
vim.g.everforest_better_performance = 1
vim.g.everforest_disable_italic_comment = 1
vim.cmd('colorscheme everforest')

-- Syntax highlighting
vim.cmd('syntax on')

-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':GFiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

-- Command to run C programs
vim.api.nvim_create_user_command('RunC', function(opts)
  vim.cmd('!./' .. vim.fn.expand('%<') .. ' ' .. opts.args)
end, { nargs = 1 })

