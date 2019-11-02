let python_highlight_all = 1

if executable('black')
    let &l:formatprg = 'black --quiet -'
endif

setlocal expandtab
setlocal formatoptions=croqj
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=8
setlocal textwidth=80

au BufWrite * :Autoformat
