" Personal .vimrc file"
" Daniele Tricoli <eriol@mornie.org>

set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidhalter/jedi-vim'
" Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'jmcantrell/vim-virtualenv'
Plug 'moll/vim-bbye'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'tomasr/molokai'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/TaskList.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

call plug#end()

"""""""""""
" General "
"""""""""""

set encoding=utf-8
set history=100
set hlsearch
set ruler
set showcmd
" Use UNIX style newlines
set ff=unix
colorscheme molokai

set guifont=Hack
set guioptions=aegit
nnoremap <T-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
" Resize splits on windows size changes
au VimResized * exe "normal! \<c-w>="
"""""""""""
" Editing "
"""""""""""

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set backspace=indent,eol,start
set wrap
set showbreak=↪

if version >= 703
    set colorcolumn=80
endif

if exists('+autochdir')
    set autochdir
endif

"set listchars=tab:»·,trail:·
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:␣
set list
if version >= 702
    autocmd BufWinLeave * call clearmatches()
endif
nnoremap <F9> :silent update<Bar>silent !xdg-open %:p &<CR>
noremap <F10> :set list!<CR>
noremap <F11> :set number!<CR>

syntax on
filetype on
filetype plugin indent on

""""""""""""""""""
" Keybindings    "
""""""""""""""""""

" Tab
nmap <A-n> :tabnew<CR>
" gz in command mode closes the current buffer
map gz :Bdelete<CR>

" fix broken Page Up/Down
" http://vimrc-dissection.blogspot.com/2009/02/fixing-pageup-and-pagedown.html
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>
set nostartofline

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

" automatically refresh display of html on saving file
" http://vim.wikia.com/wiki/VimTip1656
autocmd BufWriteCmd *.html,*.css,*.gtpl :call Refresh_firefox()
function! Refresh_firefox()
  if &modified
    write
    silent !echo  'vimYo = content.window.pageYOffset;
          \ vimXo = content.window.pageXOffset;
          \ BrowserReload();
          \ content.window.scrollTo(vimXo,vimYo);
          \ repl.quit();'  |
          \ nc -w 1 localhost 4242 2>&1 > /dev/null
  endif
endfunction

command! -nargs=1 Repl silent !echo
      \ "repl.home();
      \ content.location.href = '<args>';
      \ repl.enter(content);
      \ repl.quit();" |
      \ nc localhost 4242

nmap <leader>mh :Repl http://
" mnemonic is MozRepl Http
nmap <silent> <leader>ml :Repl file:///%:p<CR>
" mnemonic is MozRepl Local
nmap <silent> <leader>md :Repl http://localhost/
" mnemonic is MozRepl Development

" Don't create netrw history file
let g:netrw_dirhistmax=0

"""""""""""""
" Syntastic "
"""""""""""""
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '⚡'
let g:syntastic_style_warning_symbol = '⚡'
let g:syntastic_python_checkers=['python', 'flake8']
" Use C++11 as default: add a .syntastic_cpp_config for projects
" not using C++11
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']

"""""""""
" Gundo "
"""""""""

nnoremap <F5> :GundoToggle<CR>

""""""""""""
" jedi-vim "
""""""""""""

let g:jedi#show_call_signatures = 0

"""""""""""""""
" BufExplorer "
"""""""""""""""

map <A-j> <ESC>:BufExplorer<CR>

"""""""""""""""
" vim-airline "
"""""""""""""""
set laststatus=2
let g:airline_powerline_fonts = 1

"""""""""""
" Session "
"""""""""""

let g:session_autosave='yes'

"""""""""""""""""
" Indent Guides "
"""""""""""""""""

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

""""""""""
" vim-go "
""""""""""

let g:go_disable_autoinstall = 1
let g:go_fmt_command = "goimports"

"""""""""""""
" NERD Tree "
"""""""""""""

map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
