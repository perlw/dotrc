if exists("b:current_syntax")
  finish
endif

syn match   calendarDate          '^\d\+' display nextgroup=calendarWeek,calendarSchedule
syn match   calendarDate          '^\d\+-\d\+' display nextgroup=calendarWeek,calendarSchedule
syn match   calendarDate          '^\d\+-\d\+-\d\+' display nextgroup=calendarWeek,calendarSchedule
syn match   calendarWeek          'w\d\+' display nextgroup=calendarWeekday,calendarSchedule
syn keyword calendarWeekday       Mon Tue Wed Thu Fri Sat Sun nextgroup=calendarSchedule
syn match   calendarContext       '@\w\+' display contained
syn match   calendarTag           '+\w\+' display contained
syn match   calendarTime          ' \d\+ ' display contained
syn match   calendarTime          '\d\+-\d\+' display contained
syn region  calendarSchedule      start='  .*' end='$' oneline contains=calendarContext,calendarTime

hi def link calendarDate          Number
hi def link calendarWeekday       String
hi def link calendarWeek          Keyword
hi def link calendarTime          Number
hi def link calendarContext       Comment
hi def link calendarTag           Comment
hi def link calendarSchedule      Normal

let b:current_syntax = "cal"
