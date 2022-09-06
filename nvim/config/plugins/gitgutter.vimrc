augroup gitgutter
  autocmd!
  autocmd BufWritePost * GitGutter
augroup END
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_async = 1
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
let g:gitgutter_sign_removed_first_line = '|'
let g:gitgutter_sign_removed_above_and_below = '|'
let g:gitgutter_sign_modified_removed = '|'
let g:gitgutter_sign_priority = -1
let g:gitgutter_sign_allow_clobber = 1
