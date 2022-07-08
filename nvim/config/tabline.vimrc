function TabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
  return bufname(l:buflist[l:winnr - 1])
endfunction

function Tabline()
  let l:line = ''

  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let l:line ..= '%1*%3*%*'
      let l:line ..= '%#TabLineSel#'
    else
      let l:line ..= '%1*%*'
      let l:line ..= '%#TabLine#'
    endif

    let l:line ..= '%' .. (i + 1) .. 'T'
    let l:line ..= ' %{TabLabel(' .. (i + 1) .. ')} '

    if i + 1 == tabpagenr()
      let l:line ..= '%3*%1*%*'
    else
      let l:line ..= '%1*%*'
    endif
  endfor

  let l:line ..= '%#TabLineFill#%T'
  return l:line
endfunction

hi tablinesel guibg=#e78f00 guifg=lightyellow
hi tabline guibg=lightblue guifg=black
hi tablinefill guibg=grey guifg=grey
set tabline=%!Tabline()
