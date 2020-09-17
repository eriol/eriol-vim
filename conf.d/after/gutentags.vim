let g:gutentags_cache_dir = expand('~/.cache/ctags')
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.git', '.hg', '.svn', 'Makefile']
nmap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
