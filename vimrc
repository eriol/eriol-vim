" Personal .vimrc file
" Daniele Tricoli <eriol@mornie.org>

let mapleader = ","
let maplocalleader = ","

call plug#begin('~/.vim/plugged')

" YouCompleteMe is managed manually.
Plug '~/.vim/plugged/YouCompleteMe'
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

Plug 'mhinz/vim-startify'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
Plug 'airblade/vim-gitgutter'
Plug 'davidhalter/jedi-vim'
    let g:jedi#show_call_signatures = 0
Plug 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = '<C-n>'
Plug 'rust-lang/rust.vim'
    let g:rustfmt_autosave_if_config_present = 1
Plug 'racer-rust/vim-racer'
    let g:racer_experimental_completer = 1
Plug 'fatih/vim-go'
    let g:go_disable_autoinstall = 1
    let g:go_fmt_command = "goimports"
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_types = 1
Plug 'fcpg/vim-spotlightify'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
    map <A-j> <ESC>:BufExplorer<CR>
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} | Plug 'junegunn/fzf.vim'
    let g:fzf_colors =
    \ { 'fg':    ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
    let g:fzf_buffers_jump = 1

    " https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
    function! s:find_git_root()
        return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    endfunction
    command! ProjectFiles execute 'Files' s:find_git_root()

    command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

    nmap <C-p> :ProjectFiles<CR>
    nmap <C-s> :Rg<CR>
    nmap ; :Buffers<CR>
Plug 'luochen1990/rainbow', { 'on': 'RainbowToggle' }
    let g:rainbow_active = 0
    nmap <leader>r :RainbowToggle<CR>
Plug 'ludovicchabant/vim-gutentags'
    let g:gutentags_cache_dir = expand('~/.cache/ctags')
    let g:gutentags_add_default_project_roots = 0
    let g:gutentags_project_root = ['.git', '.hg', '.svn', 'Makefile']
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
Plug 'moll/vim-bbye'
    " delete current buffer without closing window
    map gz :Bdelete<CR>
Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    map <C-n> :NERDTreeToggle<CR>
    let g:NERDTreeQuitOnOpen = 1
    let g:NERDTreeMinimalUI = 1
    let g:NERDTreeIgnore = ['\.pyc$']
Plug 'w0rp/ale'
    let g:airline#extensions#ale#enabled = 1
    let g:ale_sign_warning = '🅧'
    let g:ale_sign_error = '🅧'
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let b:ale_fixers = {'rust': ['']}
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
Plug 'tpope/vim-commentary'
    noremap <C-_> :Commentary<CR>
    inoremap <C-_> <ESC>:Commentary<CR>li
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
    let g:airline_right_sep = ''
    let g:airline_left_sep = ''
    let g:airline_powerline_fonts = 1
    let g:airline_mode_map = {
        \ '__' : '-',
        \ 'n'  : 'N',
        \ 'i'  : 'I',
        \ 'R'  : 'R',
        \ 'c'  : 'C',
        \ 'v'  : 'V',
        \ 'V'  : 'V',
        \ '' : 'V',
        \ 's'  : 'S',
        \ 'S'  : 'S',
        \ '' : 'S',
        \ 't'  : 'T',
        \ }
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
    let g:polyglot_disabled = ['go', 'rust']

" Colors
Plug 'NLKNguyen/papercolor-theme'
Plug 'ajh17/spacegray.vim'
Plug 'cocopon/iceberg.vim'
Plug 'mitsuhiko/fruity-vim-colorscheme'
Plug 'morhetz/gruvbox'
    let g:gruvbox_contrast_dark = 'hard'
Plug 'tomasr/molokai'

call plug#end()

colorscheme molokai

set autoindent
set autoread
set backspace=indent,eol,start
set colorcolumn=80
set completeopt-=preview
set encoding=utf-8
set expandtab
set ff=unix
set guifont=Hack
set guioptions=aegit
set history=1000
set incsearch hlsearch
set laststatus=2
set lazyredraw
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
set wildignore+=*.pyc
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
