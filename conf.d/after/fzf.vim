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

function! ProjectFiles()
    let is_under_git_control = system('git rev-parse')
    if v:shell_error != 0
        :Files
    else
        :GitFiles --exclude-standard --cached --others
    endif
endfunction

command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
\   fzf#vim#with_preview(), <bang>0)

nmap <C-p> :call ProjectFiles()<CR>
nmap <C-s> :Rg<CR>
nmap ; :Buffers<CR>
