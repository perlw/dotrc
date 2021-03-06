" FIXME: Use fugitive for this instead.
function! s:gitModified()
  let files = systemlist('git ls-files -m 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
  let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_change_to_vcs_root = 1

let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
      \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ ]

" Nostalgia.
let g:startify_custom_header = [
      \ '',
      \ '    @@@  @@@   @@@@@@   @@@  @@@  @@@  @@@       @@@   @@@       @@@ @@@  @@@@@@@@  @@@@@@@@',
      \ '    @@@  @@@  @@@@@@@@  @@@  @@@  @@@  @@@      @@@@   @@@       @@@ @@@  @@@@@@@@  @@@@@@@@',
      \ '    @@!  @@@  @@!  @@@  @@!  !@@  @@!  !@@     @@!@!   @@!       @@! !@@  @@!       @@!',
      \ '    !@!  @!@  !@!  @!@  !@!  @!!  !@!  @!!    !@!!@!   !@!       !@! @!!  !@!       !@!',
      \ '    @!@!@!@!  @!@!@!@!   !@@!@!    !@@!@!    @!! @!!   @!!        !@!@!   @!!!:!    @!!!:!',
      \ '    !!!@!!!!  !!!@!!!!    @!!!      @!!!    !!!  !@!   !!!         @!!!   !!!!!:    !!!!!:',
      \ '    !!:  !!!  !!:  !!!   !: :!!    !: :!!   :!!:!:!!:  !!:         !!:    !!:       !!:',
      \ '    :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  !:::!!:::   :!:        :!:    :!:       :!:',
      \ '    ::   :::  ::   :::   ::  :::   ::  :::       :::    :: ::::     ::     ::        :: ::::',
      \ '     :   : :   :   : :   :   ::    :   ::        :::   : :: : :     :      :        : :: ::',
      \ ]
