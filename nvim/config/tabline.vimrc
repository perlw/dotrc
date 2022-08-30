function TabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
  let l:bufname = split(bufname(l:buflist[l:winnr - 1]), '/')

  let l:i = 0
  if len(l:bufname) > 1
    while i < len(l:bufname[0:-2])
      let l:newname = l:bufname[i][0] . l:bufname[i][len(l:bufname) / 2] . l:bufname[i][-1:]
      let l:bufname[i] = l:newname
      let i += 1
    endwhile
  endif

  return join(l:bufname, '/')
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
