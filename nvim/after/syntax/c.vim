" Vim syntax file
" Language:	C Additions
" Maintainer:	None

" Common ANSI-standard Names
syn keyword	cAnsiName	PRId8 PRIi16 PRIo32 PRIu64
syn keyword	cAnsiName	PRId16 PRIi32 PRIo64 PRIuLEAST8
syn keyword	cAnsiName	PRId32 PRIi64 PRIoLEAST8 PRIuLEAST16
syn keyword	cAnsiName	PRId64 PRIiLEAST8 PRIoLEAST16 PRIuLEAST32
syn keyword	cAnsiName	PRIdLEAST8 PRIiLEAST16 PRIoLEAST32 PRIuLEAST64
syn keyword	cAnsiName	PRIdLEAST16 PRIiLEAST32 PRIoLEAST64 PRIuFAST8
syn keyword	cAnsiName	PRIdLEAST32 PRIiLEAST64 PRIoFAST8 PRIuFAST16
syn keyword	cAnsiName	PRIdLEAST64 PRIiFAST8 PRIoFAST16 PRIuFAST32
syn keyword	cAnsiName	PRIdFAST8 PRIiFAST16 PRIoFAST32 PRIuFAST64
syn keyword	cAnsiName	PRIdFAST16 PRIiFAST32 PRIoFAST64 PRIuMAX
syn keyword	cAnsiName	PRIdFAST32 PRIiFAST64 PRIoMAX PRIuPTR
syn keyword	cAnsiName	PRIdFAST64 PRIiMAX PRIoPTR PRIx8
syn keyword	cAnsiName	PRIdMAX PRIiPTR PRIu8 PRIx16
syn keyword	cAnsiName	PRIdPTR PRIo8 PRIu16 PRIx32
syn keyword	cAnsiName	PRIi8 PRIo16 PRIu32 PRIx64

syn keyword	cAnsiName	PRIxLEAST8 SCNd8 SCNiFAST32 SCNuLEAST32
syn keyword	cAnsiName	PRIxLEAST16 SCNd16 SCNiFAST64 SCNuLEAST64
syn keyword	cAnsiName	PRIxLEAST32 SCNd32 SCNiMAX SCNuFAST8
syn keyword	cAnsiName	PRIxLEAST64 SCNd64 SCNiPTR SCNuFAST16
syn keyword	cAnsiName	PRIxFAST8 SCNdLEAST8 SCNo8 SCNuFAST32
syn keyword	cAnsiName	PRIxFAST16 SCNdLEAST16 SCNo16 SCNuFAST64
syn keyword	cAnsiName	PRIxFAST32 SCNdLEAST32 SCNo32 SCNuMAX
syn keyword	cAnsiName	PRIxFAST64 SCNdLEAST64 SCNo64 SCNuPTR
syn keyword	cAnsiName	PRIxMAX SCNdFAST8 SCNoLEAST8 SCNx8
syn keyword	cAnsiName	PRIxPTR SCNdFAST16 SCNoLEAST16 SCNx16
syn keyword	cAnsiName	PRIX8 SCNdFAST32 SCNoLEAST32 SCNx32
syn keyword	cAnsiName	PRIX16 SCNdFAST64 SCNoLEAST64 SCNx64
syn keyword	cAnsiName	PRIX32 SCNdMAX SCNoFAST8 SCNxLEAST8
syn keyword	cAnsiName	PRIX64 SCNdPTR SCNoFAST16 SCNxLEAST16
syn keyword	cAnsiName	PRIXLEAST8 SCNi8 SCNoFAST32 SCNxLEAST32
syn keyword	cAnsiName	PRIXLEAST16 SCNi16 SCNoFAST64 SCNxLEAST64
syn keyword	cAnsiName	PRIXLEAST32 SCNi32 SCNoMAX SCNxFAST8
syn keyword	cAnsiName	PRIXLEAST64 SCNi64 SCNoPTR SCNxFAST16
syn keyword	cAnsiName	PRIXFAST8 SCNiLEAST8 SCNu8 SCNxFAST32
syn keyword	cAnsiName	PRIXFAST16 SCNiLEAST16 SCNu16 SCNxFAST64
syn keyword	cAnsiName	PRIXFAST32 SCNiLEAST32 SCNu32 SCNxMAX
syn keyword	cAnsiName	PRIXFAST64 SCNiLEAST64 SCNu64 SCNxPTR
syn keyword	cAnsiName	PRIXMAX SCNiFAST8 SCNuLEAST8
syn keyword	cAnsiName	PRIXPTR SCNiFAST16 SCNuLEAST16

syn keyword	cAnsiName	errno environ

syn keyword	cAnsiName	STDC CX_LIMITED_RANGE
syn keyword	cAnsiName	STDC FENV_ACCESS
syn keyword	cAnsiName	STDC FP_CONTRACT

hi def link cAnsiName cIdentifier

" Operators
syn match cOperator	"\(<<\|>>\|==\)"
syn match cOperator	"<<\|>>\|&&\|||\|->"
syn match cOperator "&&\|||"

syn match cDelimiter	"*\+\w\+\|&\w\+"
syn match cDelimiter	"\w\+[*]\+"

" Preprocs
syn keyword cDefined defined contained containedin=cDefine
hi def link cDefined cDefine

" Delimiters
syn match cText    "[();\\]"
" foldmethod=syntax fix, courtesy of Ivan Freitas
syn match cText display "[{}]"

" Booleans
syn keyword cBoolean true false TRUE FALSE

" Links
hi def link cFunction Function
hi def link cIdentifier Identifier
hi def link cDelimiter Delimiter
" foldmethod=syntax fix, courtesy of Ivan Freitas
hi def link cBraces Delimiter
hi def link cBoolean Boolean

