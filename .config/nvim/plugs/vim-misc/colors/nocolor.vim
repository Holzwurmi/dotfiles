" NOTE: to output current colors with highlight group
" so $VIMRUNTIME/syntax/hitest.vim

hi clear
syntax reset
let g:colors_name = "nocolor"

" colors
	let cText = "white"
	let cComment = "lightgray"
	let cAction = "yellow"
	let cBackground = "black"
	let cSevereHighlight = "red"

fun <sid>hi(group, ctermfg, ctermbg, attr, ...)
	let l:attr = get(a:, 1, "")
	let l:guisp = get(a:, 2, "")

	if a:ctermfg != ""
		exec "hi " . a:group . " ctermfg=" . a:ctermfg
	endif
	if a:ctermbg != ""
		exec "hi " . a:group . " ctermbg=" . a:ctermbg
	endif
	if a:attr != ""
		exec "hi " . a:group . " cterm=" . a:attr
	endif
endfun

" Vim editor colors
	call <sid>hi("Normal", cText, "", "")
	call <sid>hi("Bold", "", "", "bold")
	call <sid>hi("Italic", "", "", "none")
	call <sid>hi("Debug", "", "", "")
	call <sid>hi("Directory", cText, "", "")
	call <sid>hi("Error", cText, "", "")
	call <sid>hi("ErrorMsg", cText, "none", "")
	call <sid>hi("SpellBad", cText, "none", "")
	call <sid>hi("Error", cText, "none", "")
	call <sid>hi("FoldColumn", cAction, "", "")
	call <sid>hi("Folded", cAction, cBackground, "")
	call <sid>hi("IncSearch", cText, "", "none")
	call <sid>hi("MatchParen", cText, "", "")
	call <sid>hi("ModeMsg", cText, "", "none")
	call <sid>hi("Search", cAction, "", "")
	call <sid>hi("SpecialKey", cText, "", "")
	call <sid>hi("Conceal", cText, cAction, "")
	call <sid>hi("NoncText", cText, "", "")
	call <sid>hi("Comment", cComment, "", "")
	call <sid>hi("Constant", cText, "", "")
	call <sid>hi("Identifier", cText, "", "none")
	call <sid>hi("PreProc", cText, "", "")
	call <sid>hi("Special", cText, "", "")
	call <sid>hi("Statement", cText, "", "")
	call <sid>hi("Todo", cAction, "none", "")
	call <sid>hi("Type", cText, "", "")
	call <sid>hi("ColorColumn", "", cSevereHighlight, "none")

" cleanup
	delf <sid>hi
	unlet cText cComment cAction cBackground
