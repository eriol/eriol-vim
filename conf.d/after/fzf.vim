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
\   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:50%:hidden', '?'),
\   <bang>0)

nmap <C-p> :ProjectFiles<CR>
nmap <C-s> :Rg<CR>
nmap ; :Buffers<CR>
