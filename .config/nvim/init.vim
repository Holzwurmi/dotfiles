" plugins
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
		!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif

	let s:pluginFolder=fnamemodify($MYVIMRC, ":p:h") . "/plugs"

	if !empty(glob(s:pluginFolder))
		let &rtp .= ','.expand(s:pluginFolder)
		call plug#begin(s:pluginFolder)
			Plug 'https://github.com/Shougo/neosnippet.vim'
			Plug 'https://github.com/tpope/vim-commentary'
			Plug 'https://github.com/tpope/vim-fugitive'
			Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
			Plug 'https://github.com/junegunn/fzf.vim'
			exec "Plug '" . s:pluginFolder . "/vim-misc'"
		call plug#end()
	endif

" indent
	set softtabstop=0
	set shiftwidth=4
	set shiftround
	set noexpandtab
	set tabstop=4

	function! FoldByIndent(lnum)
		function! IndentLevel(lnum)
			return indent(a:lnum) / &shiftwidth
		endfunction

		function! IsEmptyLine(lnum)
			return getline(a:lnum) =~? '\v^\s*$'
		endfunction

		let l:lastlevel = foldlevel(a:lnum - 1)
		if IsEmptyLine(a:lnum)
			if lastlevel > IndentLevel(a:lnum + 1) && !IsEmptyLine(a:lnum)
				return l:lastlevel - 1
			else
				return '-1'
			endif
		endif
		let l:cur = IndentLevel(a:lnum)
		let l:next = IndentLevel(a:lnum+1)
		let l:prev = IndentLevel(a:lnum-1)
		if l:cur < &fdn
			if l:cur < l:next
				return '>' . (l:cur + 1)
			elseif l:cur < l:prev
				return l:cur + 1
			else
				return l:cur
			endif
		endif
		return &fdn
	endfunction
	set fdm=expr
	set fde=FoldByIndent(v:lnum)
	set fdn=1

" tab completion
	set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind
	set suffixes+=.idx,.ilg,.inx,.out,.toc,.png,.jpg

" searching
	set fileignorecase
	set smartcase
	set ignorecase
	set nohlsearch
	set incsearch

" cmdwin
	set cmdwinheight=5
	execute printf('nnoremap : :%s', &cedit)
	execute printf('nnoremap / /%s', &cedit)
	execute printf('nnoremap ? ?%s', &cedit)
	au CmdwinEnter * startinsert
	au CmdwinEnter * nnoremap <buffer> <ESC> <C-\><C-N>
	au CmdwinEnter * nnoremap <buffer> <C-c> <C-\><C-N>
	au CmdwinEnter * inoremap <buffer> <C-c> <Esc>
	au CmdwinEnter * nnoremap <buffer> : _
	au CmdwinEnter * inoremap <buffer> <C-CR> <CR>
	au CmdwinEnter * inoremap <buffer> <expr> <backspace>
		\ col(".") == 1 ? '<C-\><C-N><C-\><C-N>' : '<backspace>'

" maps
	let mapleader = ","
	noremap <leader>. :s::g<Left><Left>
	noremap <leader>w :%s:\(<c-r>=expand("<cword>")<cr>\)::g<Left><Left>
	noremap <leader>% :%s::g<Left><Left>
	command! -nargs=* Make w | make! <args>
	noremap <leader>c :Make<Cr>
	noremap <leader>t :Make test<Cr>
	noremap <leader>r :Make run<Cr>
	cmap <leader>( \(\)<Left><Left>
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" look
	syntax on
	set cole=0
	set cc=80
	au FileType * setl cole=0
	colorscheme nocolor
	set lcs=tab:├─,eol:$,space:~,conceal:*
	set relativenumber
	set number
	set confirm
	set splitbelow
	set splitright

" neosnippet
	imap <C-k> <Plug>(neosnippet_expand_or_jump)
	smap <C-k> <Plug>(neosnippet_expand_or_jump)
	xmap <C-k> <Plug>(neosnippet_expand_target)
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
		\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	let g:neosnippet#snippets_directory =
		\ fnamemodify($MYVIMRC, ":p:h") . "/snippets"
	let g:neosnippet#disable_runtime_snippets = {'_':1}
	nnoremap <leader>s :NeoSnippetEdit -vertical -split<Cr>

" fzf
	function! s:openFzfResultOfGrepInput(word)
		let s:actionMap = {
		\ 	'': 'edit',
		\ 	'ctrl-v': 'vsplit',
		\ 	'ctrl-s': 'split',
		\ 	'ctrl-t': 'tab split'
		\ }
		let s:file = substitute(a:word[1], '\:.*', "", "")
		let s:lineNumber = substitute(a:word[1], '.\{-}\:', "", "")
		let s:lineNumber = substitute(s:lineNumber, '\:.*', "", "")
		let s:key = a:word[0]

		exec s:actionMap[s:key] . " +" . s:lineNumber . " " . s:file
	endfunction

	command! -bang -complete=dir -nargs=? ED 
		\ call fzf#run(
		\	{
		\		'source': 'grep --line-buffered --color=never -n -r "" *',
		\		'sink*': function('s:openFzfResultOfGrepInput'),
		\		'options': "--expect=ctrl-v,ctrl-s,ctrl-t",
		\		'window': {'width': 0.9, 'height': 0.6}
		\ 	}, <bang>0
		\ )

	nnoremap <leader>f :ED<CR>
