function! InsertStatuslineColor(mode)
  if a:mode ==? 'i'
    hi User1 ctermbg=lightgreen guibg=lightgreen
    hi User2 ctermfg=lightgreen guifg=lightgreen
  elseif a:mode ==? 'r'
    hi User1 ctermbg=darkmagenta guibg=darkmagenta
    hi User2 ctermfg=darkmagenta guifg=darkmagenta
  else
    hi User1 ctermbg=red guibg=red
    hi User2 ctermfg=red guifg=red
  endif
endfunction

function! InitialStatuslineColors()
  hi statusline ctermbg=yellow ctermfg=grey guibg=yellow guifg=grey
  hi statuslinenc ctermbg=grey ctermfg=grey guibg=grey guifg=grey
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

function! ScmBranch()
  if exists('b:git_dir')
    let head = fugitive#head()
    if len(head) > 30
      let head = head[0:27] . "..."
    endif
    return printf('%s', head)
  endif
  return ''
endfunction

function! FileFormatCorrect()
  return
    \(&ff == 'unix' && !has('unix')) ||
    \(&ff == 'dos' && (!has('win32') && !has('win95'))) ||
    \(&ff == 'mac' && !has('mac'))
    \ ? ','.&ff : ''
endfunction

function! Statusline(mode)
  if a:mode ==? 'active'
    let l:c1='%1*'
    let l:c2='%2*'
    let l:c3='%5*'
  elseif a:mode ==? 'inactive'
    let l:c1='%3*'
    let l:c2='%4*'
    let l:c3='%6*'
  endif

  let l:line=''
  let l:line.='%4* ' . c1 . ' %{CwdBase()} ' . c2 . '' . c3 . ' %{WebDevIconsGetFileTypeSymbol(@%)} %{pathshorten(@%)}'
  let l:line.='%m%r'
  let l:line.=' %{ScmBranch()}'
  let l:line.='%='
  let l:line.=c2 . '' . c1 . ' %y %{FileFormatCorrect()}'
  let l:line.=' %c#%l/%L %4* %*'

  let &l:statusline = l:line
endfunction

augroup statusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%{Statusline('active')}
  autocmd WinLeave,BufLeave * setlocal statusline=%{Statusline('inactive')}
augroup END
