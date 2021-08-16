" todo: language independet help system (maybe language server)
	" function! GoDoc(packageName)
	" 	execute "InScratch !go doc -all " . a:packageName
	" endfunction

	" command! -nargs=+ -complete=command Doc call GoDoc(<q-args>)
