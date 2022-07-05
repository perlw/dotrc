function! InsertStatuslineColor(mode)
  if a:mode ==? 'i'
    hi statusline guibg=lightgreen
    hi statuslinenc guibg=lightgreen
    hi User1 guibg=lightgreen
    hi User2 guifg=lightgreen
  else
    hi statusline guibg=red
    hi statuslinenc guibg=red
    hi User1 guibg=red
    hi User2 guifg=red
  endif
endfunction

function! InitialStatuslineColors()
  hi statusline guibg=lightblue guifg=grey
  hi statuslinenc guibg=lightblue guifg=lightgrey
  hi User1 guibg=lightblue guifg=black
  hi User2 guibg=#e78f00 guifg=lightblue
  hi User3 guibg=darkmagenta guifg=yellow
  hi User4 guibg=grey guifg=lightgrey
  hi User5 guibg=#e78f00 guifg=lightyellow
  hi User6 guibg=darkmagenta guifg=#e78f00
  hi User7 guibg=grey guifg=#e78f00
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InitialStatuslineColors()
call InitialStatuslineColors()

function! GitStatus()
  if empty(FugitiveGitDir(bufnr('')))
    return ''
  else
    let head = FugitiveHead()
    if head == ''
      let head = 'detached'
    else
      if len(head) > 16
        let head = head[0:14] . '..'
      endif
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
  let l:c1 = '%1*'
  let l:c2 = '%2*'
  if a:mode ==? 'active'
    let l:c3 = '%3*'
    let l:c4 = '%5*'
    let l:c5 = '%6*'
  elseif a:mode ==? 'inactive'
    let l:c3 = '%4*'
    let l:c4 = '%5*'
    let l:c5 = '%7*'
  endif

  let l:line = ''
  let l:line .= c1 . ' %t%m%r ' . c2 . ''
  let l:line .= c4 . ' %{GitStatus()} ' . c5 . '' .c3
  let l:line .= '%='
  let l:line .= c5 . '' . c4 . ' %y:%{FileFormat()} ' . c2 . '' . c1
  let l:line .= ' %c#%l/%L '

  let &l:statusline = l:line
endfunction

augroup statusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%{Statusline('active')}
  autocmd WinLeave,BufLeave * setlocal statusline=%{Statusline('inactive')}
augroup END
