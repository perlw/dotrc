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

function! GitStatus()
  if empty(FugitiveGitDir(bufnr('')))
    return ''
  else
    let head = FugitiveHead()
    if head == ''
      let head = 'detached'
    elseif len(head) > 9
      let head = head[0:7] . '…'
    endif
    let [a,m,r] = GitGutterGetHunkSummary()
    let isDirty = a || m || r
    return printf('%s%s', head, (isDirty ? '‼' : ''))
  endif
endfunction

function! FileFormat()
  return &ff
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
  let l:line .= cEdgeSlant . ' ' . cEdgeContent . ' %t%m%r ' . cMidSlant . ''
  let l:line .= cMidContent . ' %{GitStatus()} ' . cCenterBarSlant . ''
  let l:line .= '%='
  let l:line .= '' . cMidContent . ' %y:%{FileFormat()} ' . cMidSlant . '' . cEdgeContent
  let l:line .= ' %c#%l/%L ' . cEdgeSlant . '%* '

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
