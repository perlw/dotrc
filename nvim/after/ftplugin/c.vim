if filereadable("build/Makefile")
  set makeprg=cd\ build\ &&\ make
elseif filereadable(expand("%:p:h")."/Makefile")
  set makeprg=make
else
  set makeprg=gcc\ -Wall\ -Wextra\ -o\ %<\ %
endif
