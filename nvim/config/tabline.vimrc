function TabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
  return bufname(l:buflist[l:winnr - 1])
endfunction

function Tabline()
  let l:line = ''

  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      if i == 0
        let l:line ..= '%6*%*'
      else
        let l:line ..= '%3*%*'
      endif

      let l:line ..= '%#TabLineSel#'
    else
      if i == 0
        let l:line ..= '%1*%*'
      else
        let l:line ..= '%3*%*'
      endif

      let l:line ..= '%#TabLine#'
    endif

    let l:line ..= '%' .. (i + 1) .. 'T'
    let l:line ..= ' %{TabLabel(' .. (i + 1) .. ')} '
  endfor
  if i + 1 == tabpagenr()
    let l:line ..= '%6*%*'
  else
    let l:line ..= '%1*%*'
  endif

  let l:line ..= '%#TabLineFill#%T'
  return l:line
endfunction

hi tablinesel guibg=#e78f00 guifg=lightyellow
hi tabline guibg=lightblue guifg=black
hi tablinefill guibg=grey guifg=grey
set tabline=%!Tabline()
