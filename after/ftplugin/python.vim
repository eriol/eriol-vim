setlocal formatoptions=croqj
setlocal tabstop=8

let python_highlight_all = 1

if executable('black')
    let &l:formatprg = 'black --quiet -'
endif

let b:ale_fixers = ['black', 'isort']
