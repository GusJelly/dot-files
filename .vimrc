" AutoInstalling Vim-Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set termguicolors

" Install plugins
call plug#begin()

" tpope plugins:
Plug 'tpope/vim-vinegar'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-sleuth'

" Rest of the plugins:
Plug 'morhetz/gruvbox'

Plug 'liuchengxu/vim-which-key'

Plug 'tribela/vim-transparent'

Plug 'vimwiki/vimwiki'

Plug 'airblade/vim-gitgutter'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'rose-pine/vim'

call plug#end()


" Set <space> as leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Make which key activate on <leader> press
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Remaps for half page jumping
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Sensible defaults
set scrolloff=8
set number
set rnu
set nohlsearch
filetype plugin indent on
set nocompatible
syntax on
set tabstop=4
set updatetime=100
set signcolumn=yes
set colorcolumn=80
set nowrap

set mouse=a

" Colorscheme
colorscheme rosepine
set background=dark

highlight CursorLine ctermbg=NONE
highlight CursorLine guibg=NONE

" Vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]

