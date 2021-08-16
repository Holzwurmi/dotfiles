" http://kevin-berridge.blogspot.com/2008/09/vim-c-compiling.html

if exists('g:current_compiler')
    finish
endif
let g:current_compiler = '_example'

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
set errorformat=\ %#%f(%l\\\,%c):\ %m
CompilerSet makeprg=msbuild\ /nologo\ /v:q\ /property:GenerateFullPaths=true
