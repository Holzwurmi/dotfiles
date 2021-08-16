" TODO: making it asynchrone
" job_start()
" or dispatch

if exists('g:current_compiler')
    finish
endif
let g:current_compiler = '_example'

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet errorformat&		" use the default 'errorformat'
CompilerSet makeprg=dotnet\ run
