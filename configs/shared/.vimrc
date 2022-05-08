" Syntax highlighting
colorscheme pablo
syntax on

" Flash screen instead of beep sound
set visualbell

" Change how vim represents characters on the screen
set encoding=utf-8

" Set the encoding of files written
set fileencoding=utf-8

" Set line numbers
set number

" don't break up words at end of window width
set linebreak

" Specify different areas of the screen where splits should occur
set splitbelow
set splitright

" Python-specific whitespace file settings
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" ts - show existing tab with 4 spaces width
" sw - when indenting with '>', use 4 spaces width
" sts - control <tab> and <bs> keys to match tabstop

" General whitespace settings
set shiftwidth=4
filetype plugin indent on

" Allow backspace to delete indentation and inserted text
" i.e. how it works in most programs
set backspace=indent,eol,start
" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert; CTRL-W and CTRL-U
"         stop once at the start of insert.

call plug#begin("$HOME/.config/nvim/plugged")

Plug 'Valloric/YouCompleteMe'
Plug 'junegunn/fzf'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'editorconfig/editorconfig-vim'

call plug#end()
