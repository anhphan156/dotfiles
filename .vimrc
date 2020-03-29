"------
" Settings
"------

set nocompatible
set encoding=utf-8
filetype off

"colorscheme
set t_Co=16
"set background=dark

syntax on

" Line number hybrid
set nu rnu

" Indentation
filetype plugin indent on
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

"--------
" Mapping
"--------

" Open .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Exit insert mode
inoremap jk <esc>

" Delete line without putting into buffer
nnoremap \d "_dd

" Save file in normal mod
nnoremap <leader>w :w<cr>

" NerdTree configs

" Start Nerd Tree when vim starts
"autocmd vimenter * NERDTree
"autocmd VimEnter * wincmd p

" Close Nerd Tree when vim closes
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle Nerd Tree key
map <C-n> :NERDTreeToggle<CR>
