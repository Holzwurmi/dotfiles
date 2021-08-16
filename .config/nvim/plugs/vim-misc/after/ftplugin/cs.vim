" let b:did_ftplugin = 1

" match to learn in respect of regex
command AddSpaces1 %s:\(^\s*\n\)*\(\(^\s*\/\/.*\n\)*\s*\(\(private\)\|\(public\)\|\(protected\)\|\(internat\)\).*(.*)\n\):\r\2:g
command AddSpaces2 %s:\(^\s*\n\)*\(\(^\s*\/\/.*\n\)*namespace.*\n\):\r\2:g
command AddSpaces3 %s:}\(^\s*\n\)*:}\r:g
command RemoveSpaces %s:^\s*\n::g
" todo:
" let commentLine = 
" let emptyLine = 
"
function! g:Format()
	RemoveSpaces
	AddSpaces1
	AddSpaces2
	AddSpaces3
endfunction

command Format :call
