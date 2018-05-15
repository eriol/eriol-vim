" Personal .vimrc file
" Daniele Tricoli <eriol@mornie.org>

call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidhalter/jedi-vim'
    let g:jedi#show_call_signatures = 0
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
    let g:go_disable_autoinstall = 1
    let g:go_fmt_command = "goimports"
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
    map <A-j> <ESC>:BufExplorer<CR>
Plug 'jmcantrell/vim-virtualenv'
Plug 'ludovicchabant/vim-gutentags'
    let g:gutentags_project_root = ['Makefile']
    let g:gutentags_cache_dir = "~/.cache/ctags"
Plug 'moll/vim-bbye'
Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    map <C-n> :NERDTreeToggle<CR>
    let NERDTreeIgnore = ['\.pyc$']
Plug 'scrooloose/syntastic'
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
    let g:syntastic_style_error_symbol = '⚡'
    let g:syntastic_style_warning_symbol = '⚡'
    let g:syntastic_python_checkers = ['python', 'flake8']
    " Use C++11 as default: add a .syntastic_cpp_config for projects
    " not using C++11
    let g:syntastic_cpp_compiler_options = ' -std=c++11'
    let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
Plug 'sjl/gundo.vim'
    nnoremap <F5> :GundoToggle<CR>
    let g:gundo_prefer_python3 = 1
Plug 'tomasr/molokai'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
    let g:airline_powerline_fonts = 1
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
    let g:session_autoload = 'no'
    let g:session_autosave='yes'

call plug#end()


colorscheme molokai

set autochdir
set autoindent
set autoread
set colorcolumn=80
set backspace=indent,eol,start
set encoding=utf-8
set expandtab
set ff=unix
set guifont=Hack
set guioptions=aegit
set history=1000
set incsearch hlsearch
set laststatus=2
set list
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:␣
set noerrorbells
set nostartofline
set ruler
set shiftwidth=4
set shortmess+=I
set showbreak=↪
set showcmd
set softtabstop=4
set tabstop=4
set visualbell t_vb=
set wrap

" Resize splits on windows size changes
au VimResized * exe "normal! \<c-w>="

if version >= 702
    autocmd BufWinLeave * call clearmatches()
endif

""""""""""""""""""
" Keybindings    "
""""""""""""""""""

" Tab
nmap <A-n> :tabnew<CR>
" gz in command mode closes the current buffer
map gz :Bdelete<CR>
" `Ctrl-L` to clear the highlighting
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
" fix broken Page Up/Down
" http://vimrc-dissection.blogspot.com/2009/02/fixing-pageup-and-pagedown.html
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>
nnoremap <C-w>s <C-w>s<C-w>w
nnoremap <C-w>v <C-w>v<C-w>w
nnoremap <F9> :silent update<Bar>silent !xdg-open %:p &<CR>
noremap <F10> :set list!<CR>
noremap <F11> :set number!<CR>
nnoremap <T-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

let python_highlight_all = 1
set wildignore+=*.pyc
augroup Python
  au!
  au FileType python set autoindent cindent et sts=4 sw=4 tw=80 fo=croq
  "au FileType python set foldenable foldmethod=indent

  " Disable docstring window auto popup for vim-jedi
  autocmd FileType python setlocal completeopt-=preview
augroup END

au FileType rst set autoindent cindent et sts=3 sw=3 tw=80 fo=croq
autocmd BufRead,BufNewFile *.html set shiftwidth=2

" Don't create netrw history file
let g:netrw_dirhistmax=0
