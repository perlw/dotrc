" Statusline
function! InsertStatuslineColor(mode)
  if a:mode ==? 'i'
    hi User1 ctermbg=darkgreen guibg=darkgreen
    hi User2 ctermfg=darkgreen guifg=darkgreen
  elseif a:mode ==? 'r'
    hi User1 ctermbg=darkmagenta guibg=darkmagenta
    hi User2 ctermfg=darkmagenta guifg=darkmagenta
  else
    hi User1 ctermbg=red guibg=red
    hi User2 ctermfg=red guifg=red
  endif
endfunction
function! InitialStatuslineColors()
  hi statusline ctermbg=grey ctermfg=yellow guibg=grey guifg=yellow
  hi User1 ctermbg=darkgrey ctermfg=yellow guibg=darkgrey guifg=yellow
  hi User2 ctermbg=gray ctermfg=darkgrey guibg=grey guifg=darkgrey
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
function! CwdBase()
  return fnamemodify(getcwd(), ':t')
endfunction

set statusline=
set statusline+=%1*\ %{CwdBase()}\ %2*%*\ %{WebDevIconsGetFileTypeSymbol(@%)}\ %{pathshorten(@%)}
set statusline+=%m%r
set statusline+=\ %{ScmBranch()}
set statusline+=%=
set statusline+=%2*%1*\ %y
set statusline+=\ %c#%l/%L\ %*
