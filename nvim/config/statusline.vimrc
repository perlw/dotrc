function! InitialStatuslineColors()
  hi statusline guibg=lightgrey guifg=grey
  hi statuslinenc guibg=grey guifg=grey
  hi User1 guibg=grey guifg=lightblue
  hi User2 guibg=lightblue guifg=black
  hi User3 guibg=#e78f00 guifg=lightblue
  hi User4 guibg=#e78f00 guifg=lightyellow
  hi User5 guibg=darkmagenta guifg=#e78f00
  hi User6 guibg=grey guifg=#e78f00
endfunction

function! InsertStatuslineColor(mode)
  if a:mode ==? 'i'
    hi User1 guifg=lightgreen
    hi User2 guibg=lightgreen
    hi User3 guifg=lightgreen
  else
    hi User1 guifg=red
    hi User2 guibg=red
    hi User3 guifg=red
  endif
endfunction

function! Statusline(mode)
  let l:cEdgeSlant = '%1*'
  let l:cEdgeContent = '%2*'
  let l:cMidSlant = '%3*'
  let l:cMidContent = '%4*'
  if a:mode ==? 'active'
    let l:cCenterBarSlant = '%5*'
  elseif a:mode ==? 'inactive'
    let l:cCenterBarSlant = '%6*'
  endif

  let l:line = ''
  let l:line .= '%6*' . cMidContent . '' . cMidSlant . ''
  let l:line .= cEdgeContent . ' %t%m%r '
  let l:line .= cMidSlant . '' . cMidContent . '' . cCenterBarSlant . ''
  let l:line .= '%='
  let l:line .= '' . cMidContent . '' . cMidSlant . '' . cEdgeContent
  let l:line .= ' %c#%l/%L ' . cMidSlant . '' . cMidContent . '' . '%6*%*'

  let &l:statusline = l:line
endfunction

augroup statusline
  autocmd!
  autocmd InsertEnter * call InsertStatuslineColor(v:insertmode)
  autocmd InsertChange * call InsertStatuslineColor(v:insertmode)
  autocmd InsertLeave * call InitialStatuslineColors()
  autocmd WinEnter,BufEnter * setlocal statusline=%{Statusline('active')}
  autocmd WinLeave,BufLeave * setlocal statusline=%{Statusline('inactive')}
augroup END
call InitialStatuslineColors()
