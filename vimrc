" Personal .vimrc file
" Daniele Tricoli <eriol@mornie.org>

let mapleader = ","
let maplocalleader = ","

runtime! conf.d/before/*.vim

call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'Raimondi/delimitMate'
Plug 'andymass/vim-matchup'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'Konfekt/FastFold'
Plug 'kalekundert/vim-coiled-snake'
Plug 'davidhalter/jedi-vim'
Plug 'pearofducks/ansible-vim'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'fcpg/vim-spotlightify'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} | Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow', { 'on': 'RainbowToggle' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'moll/vim-bbye'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'embear/vim-localvimrc'
Plug 'vimwiki/vimwiki'

" Colors
Plug 'NLKNguyen/papercolor-theme'
Plug 'ajh17/spacegray.vim'
Plug 'cocopon/iceberg.vim'
Plug 'mitsuhiko/fruity-vim-colorscheme'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'

call plug#end()

runtime! conf.d/after/*.vim

colorscheme molokai

set autoindent
set autoread
set backspace=indent,eol,start
" set cmdheight=2
set colorcolumn=80
set completeopt=menu,noinsert,noselect
set encoding=utf-8
set expandtab
set ff=unix
set guifont=Hack
set guioptions=aegit
set hidden
set history=1000
set incsearch hlsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:␣
set nobackup
set noerrorbells
set nofoldenable
set nostartofline
set nowritebackup
set ruler
set shiftwidth=4
set shortmess+=Ic
set showbreak=↪
set showcmd
set signcolumn=yes
set softtabstop=4
set tabstop=4
set textwidth=80
set updatetime=300
set visualbell t_vb=
set wildignore+=*.py[co],*/__pycache__/
set wrap

" Resize splits on windows size changes
augroup ResizeSplits
    autocmd!
    autocmd VimResized * exe "normal! \<c-w>="
augroup END
" Use a better vertical separator for splits.
set fillchars+=vert:│

if version >= 702
    augroup ClearMarches
        autocmd!
        autocmd BufWinLeave * call clearmatches()
    augroup END
endif

" Go to the directory of the current open file only for the current window.
nnoremap <leader>lcd :lcd %:p:h<CR>:pwd<CR>

""""""""""""""""""
" Keybindings    "
""""""""""""""""""

" Tab.
nmap <A-n> :tabnew<CR>
" `Ctrl-L` to clear the highlighting.
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
" Fix broken Page Up/Down.
" http://vimrc-dissection.blogspot.com/2009/02/fixing-pageup-and-pagedown.html
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>

nnoremap <C-w>s <C-w>s<C-w>w
nnoremap <C-w>v <C-w>v<C-w>w

nnoremap <T-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <T-F9> :silent update<Bar>silent !xdg-open %:p &<CR>
noremap <T-F10> :set list!<CR>
noremap <T-F11> :set number!<CR>

" Don't create netrw history file.
let g:netrw_dirhistmax=0

runtime vimrc.local
runtime vimrc.last
