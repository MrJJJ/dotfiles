hi MyA ctermfg=black ctermbg=green guifg=white guibg=red
hi MyC ctermfg=black ctermbg=yellow guifg=white guibg=blue
hi MyG ctermfg=black ctermbg=red guifg=white guibg=black
hi MyT ctermfg=black ctermbg=blue guifg=white guibg=green
hi MyGap ctermfg=none ctermbg=none guifg=white guibg=grey
hi sp ctermfg=none ctermbg=none guifg=white guibg=grey

syn match MyA "[A]"
syn match MyC "[C]"
syn match MyG "[G]"
syn match MyT "[T]"
syn match MyGap "-"
syn match MyGap "N"
syn region sp start="^>" end="$"


syn match MyM "[M]"
syn match MyR "[R]"
syn match MyH "[H]"
syn match MyL "[L]"
syn match MyF "[F]"
syn match MyE "[E]"
syn match MyD "[D]"
syn match MyY "[Y]"
syn match MyS "[S]"
syn match MyN "[N]"
syn match MyP "[P]"
syn match MyK "[K]"
syn match MyW "[W]"
syn match MyV "[V]"
syn match MyI "[I]"
syn match MyQ "[Q]"

hi MyA ctermfg=black ctermbg=green guifg=white guibg=red
hi MyL ctermfg=black ctermbg=green guifg=white guibg=red
hi MyF ctermfg=black ctermbg=green guifg=white guibg=red
hi MyV ctermfg=black ctermbg=green guifg=white guibg=red
hi MyW ctermfg=black ctermbg=green guifg=white guibg=red
hi MyI ctermfg=black ctermbg=green guifg=white guibg=red

hi MyS ctermfg=black ctermbg=blue guifg=white guibg=green
hi MyN ctermfg=black ctermbg=blue guifg=white guibg=green
hi MyQ ctermfg=black ctermbg=blue guifg=white guibg=green

hi MyR ctermfg=black ctermbg=yellow guifg=white guibg=blue
hi MyK ctermfg=black ctermbg=yellow guifg=white guibg=blue

hi MyE ctermfg=black ctermbg=cyan guifg=white guibg=blue
hi MyD ctermfg=black ctermbg=cyan guifg=white guibg=blue

hi MyH ctermfg=black ctermbg=darkgreen guifg=white guibg=blue
hi MyY ctermfg=black ctermbg=darkgreen guifg=white guibg=blue

hi MyP ctermfg=black ctermbg=darkyellow guifg=white guibg=blue

hi MyM ctermfg=black ctermbg=darkblue guifg=white guibg=blue


"disable hilight syntax
let g:syntaxon = 1

map <F2> :call ToggleSyntax()<cr>
function! ToggleSyntax()
	if g:syntaxon == 1
		set syntax=off
		let g:syntaxon = 0
	else
		set syntax=align
		let g:syntaxon = 1
	endif
endfunction

""" Uncomment if you want the wordwrapping to be autmatically toggled.
 set nowrap
" silent g/>/d
" silent undo

set statusline="%{substitute(getline(\".\"),\" .*\",\"\",\"\")}"
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P

set ttyfast
set ttyscroll=3
set lazyredraw
set synmaxcol=1000

function! Seqviewer()
call OneLine()
exec "silent set noswapfile"
exec "silent w! .%z"
exec "silent normal gg"
exec "silent 1"
exec "silent 8vsplit! .%z"
exec "silent set nonu"
exec "silent set scrollbind"
exec "silent g!/^>/d"
"exec "silent w! .%z"
exec "silent wincmd l "
exec "silent set scrollbind"
exec "silent g/^>/d"
let g:seqviewer="active"
endfunction
"map <silent> gii :call Seqviewer()<CR>

function! Unseqviewer()
exec "silent set noswapfile"
exec "silent w! .%zz"
exec "wincmd h "
exec "silent w! %"
exec "silent normal y<CR>"
exec "wincmd l "
exec 'silent %!paste -d"\n" .%z .%zz'
exec "wincmd h "
exec "q!"
exec ":set nu"
exec "silent !rm .%z .%zz"
exec "redraw!"
unlet g:seqviewer
endfunction
"map <silent> gII :call Unseqviewer()<CR>

function! ToggleSeqViewer()
	if exists("g:seqviewer")
		call Unseqviewer()
	else
		call Seqviewer()
	endif
endfunction
map <silent> gi :call ToggleSeqViewer()<CR>


function! SafeSave() "Prevent to save in seqviewer mode
	if exists("g:seqviewer")
		call Unseqviewer()
	endif
endfunction
map ZZ :call SafeSave()<CR> :x<CR>
map ZQ :call SafeSave()<CR> :q!<CR>
map zs :call SafeSave()<CR> :w<CR>

"Navigation
map L zL
map H zH

"map n 3l
"map p 3h

"""""""""""""Oneline or not"""""""""""""
"One seq = One line for fasta
function! OneLine()
	exec 'silent g/^>/s/$/@/g'
	exec 'silent g/^>/s/^/@/g'
	exec 'silent %s/\n//g'
	exec 'silent %s/@/\r/g'
	exec 'silent 1d'
    let g:oneline="yes"
endfunction

"99 sites by line
function! MaxSitesByLine()
	exec '%s/\(.\{66\}\)/\1\r/g'
    unlet g:oneline
endfunction

function! ToggleOneLine()
	if exists("g:oneline")
		call MaxSitesByLine()
	else
		call OneLine()
	endif
endfunction
map <silent> ga :call ToggleOneLine()<CR>

"map <silent> ga :call OneLine()<CR>
"map <silent> gA :call MaxSitesByLine()<CR>

