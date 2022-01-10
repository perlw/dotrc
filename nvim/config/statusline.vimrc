" Statusline
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
  hi statusline ctermbg=yellow ctermfg=darkmagenta guibg=yellow guifg=darkmagenta
  hi User1 ctermbg=lightblue ctermfg=black guibg=lightblue guifg=black
  hi User2 ctermbg=darkmagenta ctermfg=lightblue guibg=darkmagenta guifg=lightblue
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

set statusline=
set statusline+=%1*\ %{CwdBase()}\ %2*%*\ %{WebDevIconsGetFileTypeSymbol(@%)}\ %{pathshorten(@%)}
set statusline+=%m%r
set statusline+=\ %{ScmBranch()}
set statusline+=%=
set statusline+=%2*%1*\ %y
set statusline+=\ %c#%l/%L\ %*
