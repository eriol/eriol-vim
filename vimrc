" Eriol's .vimrc

call pathogen#infect()
" Manually install Powerline
set rtp+=~/.vim/bundle/poweline/powerline/bindings/vim


"""""""""""
" General "
"""""""""""

set encoding=utf-8
set nocompatible
set history=100
set hlsearch
set ruler
set showcmd
" Use UNIX style newlines
set ff=unix
colorscheme blackboard

set guifont=DejaVu\ Sans\ Mono
" Disable scroolbars, menù and toolbar: must be enabled first to work :(
set guioptions+=LlRrb
set guioptions-=LlRrb
set guioptions-=m
set guioptions-=T
nnoremap <T-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

"""""""""""
" Editing "
"""""""""""

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set backspace=indent,eol,start
set wrap

if version >= 703
    set colorcolumn=80
endif

if exists('+autochdir')
    set autochdir
endif

"set listchars=tab:»·,trail:·
set listchars=tab:▸\ ,trail:·,eol:¬
set list
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
map gz :bdelete<CR>

" g[bB] in command mode switch to the next/prev. buffer
map gb :bnext<CR>
map gB :bprev<CR>

" fix broken Page Up/Down
" http://vimrc-dissection.blogspot.com/2009/02/fixing-pageup-and-pagedown.html
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>
set nostartofline

let python_highlight_all = 1
augroup Python
  au!
  au FileType python set autoindent cindent et sts=4 sw=4 tw=80 fo=croq
  "au FileType python set foldenable foldmethod=indent
augroup END

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


"""""""""""""
" Syntastic "
"""""""""""""

let g:syntastic_error_symbol='✗✗'
let g:syntastic_warning_symbol='⚠⚠'
let g:syntastic_style_error_symbol='✗✗'
let g:syntastic_style_warning_symbol='⚠⚠'

"""""""""
" Gundo "
"""""""""

nnoremap <F5> :GundoToggle<CR>

"""""""""""""""
" BufExplorer "
"""""""""""""""

" CTRL+b opens the buffer list
map <C-j> <ESC>:BufExplorer<CR>

"""""""""""""
" Powerline "
"""""""""""""

if has("gui_running")
    python from powerline.vim import setup as powerline_setup
    python powerline_setup()
    python del powerline_setup
    set laststatus=2
endif

"""""""""""
" Session "
"""""""""""

let g:session_autosave='yes'
