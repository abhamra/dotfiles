syntax on
filetype plugin indent on

set fileformat=unix
set encoding=UTF-8

set tabstop=4
set softtabstop=4
set shiftwidth=4
set pumheight=10
set autoindent
set smartindent
set smarttab
set nowrap
set nu! rnu!
set scrolloff=8
set showcmd
set noerrorbells visualbell t_vb=
set clipboard=unnamed
set ignorecase
set smartcase
set incsearch
set hlsearch
set cursorline

" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" update textwidth for latex files
autocmd bufreadpre *.tex setlocal textwidth=115
autocmd bufreadpre *.tex setlocal wrap

set clipboard=unnamedplus

so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim
set mouse=a

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set ttimeout
set ttimeoutlen=1
set ttyfast


" For vim-tex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let maplocalleader = ","

" For UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" For CoC
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <buffer> <tab> <c-r>=(UltiSnips#CanExpandSnippet() ? UltiSnips#ExpandSnippet() : coc#pum#visible() ? coc#pum#next(1) : "\<Tab>")<cr>
" inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree
let g:NERDCeateDefaultMappings = 0
let g:NERDSpaceDelims = 1
:nmap <C-_> <PLug>NERDCommenterInvert
:vmap <C-_> <Plug>NERDCommenterInvert
let mapleader=","
" map <Leader>v :rightb vert term ++close<cr>
" map <Leader>h :bel term ++close<cr>

set termguicolors
set background=dark
colorscheme gruvbox8_hard
