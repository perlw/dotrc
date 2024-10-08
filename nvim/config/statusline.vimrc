function! InitialStatuslineColors()
  hi statusline guibg=darkgray guifg=grey
  hi statuslinenc guibg=grey guifg=grey
  hi User1 guibg=lightblue guifg=black
  hi User2 guibg=#e78f00 guifg=lightyellow
  hi User3 guibg=darkmagenta guifg=#e78f00
  hi User4 guibg=grey guifg=#e78f00
endfunction

function! InsertStatuslineColor(mode)
  if a:mode ==? 'i'
    hi User1 guibg=lightgreen
  else
    hi User1 guibg=red
  endif
endfunction

function! Statusline(mode)
  let l:cEdgeBar = '%1*'
  let l:cMidBar = '%2*'
  if a:mode ==? 'active'
    let l:cCenterBar = '%3*'
  elseif a:mode ==? 'inactive'
    let l:cCenterBar = '%4*'
  endif

  let l:line = ''
  let l:line .= cMidBar . ' '
  let l:line .= cEdgeBar . ' %t%m%r '
  let l:line .= cMidBar . ' ' . cCenterBar . ' '
  let l:line .= '%='
  let l:line .= cMidBar . ' ' . cEdgeBar
  let l:line .= ' %c#%l/%L ' . cMidBar . ' '

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
