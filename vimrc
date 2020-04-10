" Personal .vimrc file
" Daniele Tricoli <eriol@mornie.org>

let mapleader = ","
let maplocalleader = ","

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
Plug 'racer-rust/vim-racer'
    let g:racer_experimental_completer = 1
Plug 'fatih/vim-go'
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
    nmap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    " nmap <silent> <C-d> <Plug>(coc-range-select)
    " xmap <silent> <C-d> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    " Extensions
    let g:coc_global_extensions = ['coc-css', 'coc-rls', 'coc-snippets']
Plug 'moll/vim-bbye'
    " delete current buffer without closing window
    map gz :Bdelete<CR>
Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'w0rp/ale'
    let g:airline#extensions#ale#enabled = 1
    let g:ale_sign_warning = '🅧'
    let g:ale_sign_error = '🅧'
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_fix_on_save = 1
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
Plug 'tpope/vim-commentary'
    noremap <C-_> :Commentary<CR>
    inoremap <C-_> <ESC>:Commentary<CR>li
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Lokaltog/vim-easymotion'
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
