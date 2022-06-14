function! InsertStatuslineColor(mode)
  if a:mode ==? 'i'
    hi User1 ctermbg=lightgreen guibg=lightgreen
    hi User2 ctermfg=lightgreen guifg=lightgreen
    hi User3 ctermbg=lightgreen guibg=lightgreen
    hi User4 ctermfg=lightgreen guifg=lightgreen
  elseif a:mode ==? 'r'
    hi User1 ctermbg=darkmagenta guibg=darkmagenta
    hi User2 ctermfg=darkmagenta guifg=darkmagenta
    hi User3 ctermbg=darkmagenta guibg=darkmagenta
    hi User4 ctermfg=darkmagenta guifg=darkmagenta
  else
    hi User1 ctermbg=red guibg=red
    hi User2 ctermfg=red guifg=red
    hi User3 ctermbg=red guibg=red
    hi User4 ctermfg=red guifg=red
  endif
endfunction

function! InitialStatuslineColors()
  hi statusline ctermbg=grey ctermfg=grey guibg=grey guifg=grey
  hi statuslinenc ctermbg=grey ctermfg=lightgrey guibg=grey guifg=lightgrey
  hi User1 ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
  hi User2 ctermbg=darkmagenta ctermfg=lightblue guibg=darkmagenta guifg=lightblue
  hi User3 ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
  hi User4 ctermbg=grey ctermfg=lightblue guibg=grey guifg=lightblue
  hi User5 ctermbg=darkmagenta ctermfg=yellow guibg=darkmagenta guifg=yellow
  hi User6 ctermbg=grey ctermfg=lightgrey guibg=grey guifg=lightgrey
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InitialStatuslineColors()
call InitialStatuslineColors()

function! GitStatus()
  if empty(FugitiveGitDir(bufnr('')))
    return ''
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
  if a:mode ==? 'active'
    let l:c1 = '%1*'
    let l:c2 = '%2*'
    let l:c3 = '%5*'
  elseif a:mode ==? 'inactive'
    let l:c1 = '%3*'
    let l:c2 = '%4*'
    let l:c3 = '%6*'
  endif

  let l:line = ''
  let l:line .= '%4* ' . c1 . ' %{CwdBase()} ' . c2 . '' . c3 . ' %t'
  let l:line .= '%m%r'
  let l:line .= ' %{GitStatus()}'
  let l:line .= '%='
  let l:line .= c2 . '' . c1 . ' %y:%{FileFormat()}'
  let l:line .= ' %c#%l/%L %4* %*'

  let &l:statusline = l:line
endfunction

augroup statusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%{Statusline('active')}
  autocmd WinLeave,BufLeave * setlocal statusline=%{Statusline('inactive')}
augroup END
