function TabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

function Tabline()
  let line = ''

  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let line ..= '%7*%*'
      let line ..= '%#TabLineSel#'
    else
      let line ..= '%8*%*'
      let line ..= '%#TabLine#'
    endif

    let line ..= '%' .. (i + 1) .. 'T'

    let line ..= ' %{TabLabel(' .. (i + 1) .. ')} '

    if i + 1 == tabpagenr()
      let line ..= '%7*%*'
    else
      let line ..= '%8*%*'
    endif
  endfor

  let line ..= '%#TabLineFill#%T'

  return line
endfunction

hi User7 ctermbg=grey ctermfg=darkmagenta guibg=grey guifg=darkmagenta
hi User8 ctermbg=grey ctermfg=lightblue guibg=grey guifg=lightblue
hi tablinesel ctermbg=darkmagenta ctermfg=yellow guibg=darkmagenta guifg=yellow
hi tabline ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
hi tablinefill ctermbg=grey ctermfg=grey guibg=grey guifg=grey
set tabline=%!Tabline()
