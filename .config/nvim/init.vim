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

" Go-specific whitespace file settings
au BufNewFile,BufRead *.go setlocal noet tabstop=4 shiftwidth=4 softtabstop=4

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

" Auto complete
Plug 'Valloric/YouCompleteMe'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Git gutter
Plug 'airblade/vim-gitgutter'

" Status bar
Plug 'vim-airline/vim-airline'

" Git wrapper with :G
Plug 'tpope/vim-fugitive'

" Editorconfig file support
Plug 'editorconfig/editorconfig-vim'

" Theme
Plug 'sainnhe/everforest'

" Terraform
Plug 'hashivim/vim-terraform'

" Go support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

if has('termguicolors')
  set termguicolors
endif

set background=dark

let g:everforest_background = 'soft'
let g:everforest_better_performance = 1
let g:everforest_disable_italic_comment = 1
let g:airline_theme = 'everforest'

syntax on
colorscheme everforest

