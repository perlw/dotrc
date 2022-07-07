let g:clang_format#detect_style_file = 1
let g:clang_format#auto_formatexpr = 1
augroup clang_format
  autocmd!
  autocmd FileType c ClangFormatAutoEnable
  autocmd FileType cpp ClangFormatAutoEnable
augroup END
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
