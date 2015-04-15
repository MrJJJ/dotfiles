"automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc
map zv :so ~/.vimrc<CR>


"Activation de la coloration et de l'intendation
filetype plugin on
"set runtimepath+=/usr/share/vim/addons/

"working directory same as file you are editing
set autochdir

"Automatically see when file change
set autoread

"Copy Paste in the xclipboard
if has("unnamedplus") && has("xterm_clipboard") && hostname() == 'ultra'
set clipboard=unnamedplus
endif

"Afficher les n° de ligne
set nu

"Activer la souris dans vim (dans gvim elle est déjà active)
set mouse=a
set mouse=r

"Afficher les parenthèses correspondantes
set showmatch

"Modifier la taille des tabulations
set tabstop=3
set shiftwidth=3
set softtabstop=3
"set expandtab "supprime les tabulations et met des espaces

"automatically save any changes made to the buffer before it is hidden.
set autowrite

"Recherche
set incsearch
set hlsearch
nnoremap <C-c> :nohl<CR><Esc>
nnoremap i :nohl<CR>i
nnoremap a :nohl<CR>a
nnoremap c :nohl<CR>c
nnoremap o :nohl<CR>o
"autocmd cursormoved * set nohlsearch
"noremap n :set hlsearch<cr>n
"noremap N :set hlsearch<cr>N
"noremap / :set hlsearch<cr>/
"noremap ? :set hlsearch<cr>?
"nnoremap <ESC> <ESC>:nohlsearch<CR>
set ignorecase
set smartcase

"Completion
set wmnu "affiche le menu
"set wildmode=list:longest,list:full "affiche toutes les possibilités
set wildmode=longest:full,full "affiche toutes les possibilités
set wcm=<C-l>
"cmap <C-h> <C-p>
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz "ignorer certains types de fichiers pour la complétion des includes
"imap <Tab> <C-X><C-F>

"Folding
set foldmethod=indent "va fold selon indentation
set foldmethod=syntax "va fold selon la syntaxe
set foldlevel=99 "ouvre les folds jusqu'au niveau demandé (99=tous)
function! MyFoldFunction()
let line = getline(v:foldstart)
let sub = substitute(line,'/\*\|\*/\|^\s+', '', 'g')
let lines = v:foldend - v:foldstart + 1
return v:folddashes.sub.'...'.lines.' Lines...'.getline(v:foldend)
endfunction

"save folding
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 
set foldmethod=expr
set foldexpr=FoldTree(v:lnum)
function! FoldTree(lnum)
	let numlines = lines('$')
	let previousLine = a:lnum - 1
	if getline(a:lnum) =~ '\v^###*'
		return '0'
	elseif getline(a:lnum) =~ '\v^#-*'
		return '1'
	elseif getline(a:lnum) =~ '\v^ #-*'
		return '2'
	elseif getline(a:lnum) =~ '\v^#@<!'
		return '3'
	endif
endfunction


"Relative number only in normal mode
"set rnu
"au InsertEnter * :set nu
"au InsertLeave * :set rnu
"au FocusLost * :set nu
"au FocusGained * :set rnu



"set foldmethod=syntax "Réduira automatiquement les fonctions et blocs (#region en C# par exemple)
"set foldtext=MyFoldFunction() "on utilise notre fonction (optionnel)


"Orthographe
"set spelllang=en,fr
"set spell
"set spellsuggest=5

"Afficher la ligne du curseur
"set cursorline 

iab #i #include


set autoindent "Auto-indentation


"set backup "Active le backup de vos fichiers en cas de plantage
"set backupdir=$HOME/.vimbackup "Le dossier où seront placés vos backup

"set scrolloff=5 "Keeps cursor x lines from the bottom of the screen


"SYNTAX HILIGHT
"ouvrir les fichiers word et openoffice
au BufReadCmd *.docx,*.xlsx,*.pptx call zip#Browse(expand("<amatch>"))
au BufReadCmd *.odt,*.ott,*.ods,*.ots,*.odp,*.otp,*.odg,*.otg call zip#Browse(expand("<amatch>"))

"Dotfiles of vim (swp, undofile...)
if isdirectory($HOME . '/.vim/bck') == 0
  :silent !mkdir -p ~/.vim/bck >/dev/null 2>&1
endif
if has('persistent_undo')
	set undofile "persistent undo
	set undolevels=100 "100 persistent undo available
	set undodir=~/.vim/bck// "save undofile in .vim/bck
endif
set directory=~/.vim/bck// "save swap files in .vim/bck
set noswapfile


"Turn of scrolling (fastier)
"set ttyscroll=0
"Have a fast terminal conection
set ttyfast
"Make the status line a little bit more informative.
"
"" Make the status line a little bit more informative.
set statusline=%F%m%r%h%w\ [%p%%]\ <Format=%{&ff}>\ <Type=%Y>\ <%04l,%03v>


"####################
"###   Filetype   ###
"####################
"
"gerer le *.R
au BufRead,BufNewFile *.R set filetype=r 
au BufRead,BufNewfile *.fas set filetype=align
au BufRead,BufNewfile *.fasta set filetype=align
au BufRead,BufNewfile *.tex set filetype=tex
au BufRead,BufNewfile *.md set filetype=markdown

set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/french

"
" " configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/stl
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4
set tags+=~/.vim/tags/cpp

" build tags of your own project with CTRL+F12
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
inoremap <F12> <Esc>:!ctags -R --c++-kinds=+pv --fields=+iaS --extra=+q .<cr>

" OmniCppComplete
 let OmniCpp_NamespaceSearch = 1
 let OmniCpp_GlobalScopeSearch = 1
 let OmniCpp_ShowAccess = 1
 let OmniCpp_MayCompleteDot = 1
 let OmniCpp_MayCompleteArrow = 1
 let OmniCpp_MayCompleteScope = 1
 let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
 au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
 set completeopt=menuone,menu,longest,preview

"set foldmethod=indent

"naviguer entre fenêtres
noremap <S-W> <C-W>
noremap <C-L> <C-W>

nnoremap & :s/<c-r><c-w>//g<left><left>
nnoremap && :%s/<c-r>=expand('<cword>')<cr>//gc<left><left><left>

"Permettre d'ouvrir plus d'onglets qu'autorisé
set tabpagemax=50

"CSV

function! CSVH(colnr)
      if a:colnr > 1 
         let n = a:colnr - 1 
         execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
         execute 'normal! 0'.n.'f,'
     elseif a:colnr == 1
         match Keyword /^[^,]*/
         normal! 0
     else
         match
     endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)




"################
"###   look   ###
"################
filetype indent on
set autoindent

syntax enable "enable my syntax
colorscheme default
set background=light
set t_Co=256


"syntax code
hi Statement ctermfg=yellow

"### tab ###
hi TabLineFill cterm=none
hi TabLineFill ctermbg=none
hi TabLine ctermfg=14
hi TabLine ctermbg=none
hi TabLine cterm=none
hi TabLine cterm=none
hi TabLineSel ctermbg=none
hi TabLineSel ctermfg=green
hi TabLineSel cterm=bold


"### popup completion ###
hi Pmenu ctermbg=black
hi Pmenu ctermfg=14
hi PmenuSel ctermfg=yellow ctermbg=black
hi PmenuSbar ctermfg=black ctermbg=black
hi PmenuThumb ctermfg=14 ctermbg=none


"### line number ###
"hi LineNr ctermbg=236
hi LineNr ctermbg=none
hi LineNr ctermfg=14
hi SpellBad ctermbg=none ctermfg=red

"### fold ###
hi Folded ctermfg=cyan ctermbg=none
"hi Folded ctermfg=cyan ctermbg=236
"function! MyFoldText() " {{{2
    "let suba = getline(v:foldstart)
    "let suba = substitute(suba, '/\*\|\*/\|{{{\d\=\|}}}\d\=', '', 'g')
    "let suba = substitute(suba, '\s*$', '', '')
    "let subb = getline(v:foldend)
    ""let subb = substitute(subb, '/\*\|\*/\|{{{\d\=\|}}}\d\=', '', 'g')
    ""let subb = substitute(subb, '^\s*', '', '')
    ""let subb = substitute(subb, '\s*$', '', '')
    "let lines = v:foldend - v:foldstart + 1
    "let text = suba
    ""if lines > 1 && strlen(subb) > 0
    ""let text .= ' ... '.subb
    ""endif
    "let fillchar = matchstr(&fillchars, 'fold:.')
    "if strlen(fillchar) > 0
      "let fillchar = fillchar[-1:]
    "else
      "let fillchar = '-'
    "endif
    "let lines = repeat(fillchar, 4).' ' . lines . ' lines '.repeat(fillchar, 3)
    "if has('float')
      "let nuw = max([float2nr(log10(line('$')))+3, &numberwidth])
    "else
      "let nuw = &numberwidth
    "endif
    "let n = winwidth(winnr()) - &foldcolumn - nuw - strlen(lines)
    "let text = text[:min([strlen(text), n])]
    "if text[-1:] != ' '
      "if strlen(text) < n
        "let text .= ' '
      "else
        "let text = substitute(text, '\s*.$', '', '')
      "endif
    "endif
    "let text .= repeat('-', n - strlen(text))
    "let text .= lines
    "return text
  "endfunction
  
  function! FoldTreeLook() " {{{2
	  "get first non-blank line
	  let fs = v:foldstart
	  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
	  endwhile
	  if fs > v:foldend
		  let line = getline(v:foldstart)
	  else
		  let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	  endif
	  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	  let foldSize = 1 + v:foldend - v:foldstart
	  let foldSizeStr = " " . foldSize . " lines "
	  let foldLevelStr = repeat(" ", v:foldlevel/4)
	  let lineCount = line("$")
	  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
	  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
	  let indent = 1
	  let previousLine = a:lnum - 1
	  while previousLine > 0
		  if getline(previousLine) =~ '\v^###*'
			  let indent = 0
			  break
		  elseif getline(previousLine) =~ '\v^#-*'
			  let indent = 0
			  break
		  elseif getline(previousLine) =~ '\v^ #-*'
			  let indent = 1
			  break
		  endif
		  let previousLine -= 1
	  endwhile
	  let indentStr = repeat(" ", indent)
	  return indentStr . '#     ' . foldSizeStr . foldPercentage . '                                                                                                                                                                                                                                                                                                         '
  endf
set foldtext=FoldTreeLook()

"### parenthesis match ###
hi MatchParen cterm=bold ctermfg=yellow ctermbg=black

"### visual mode ###
hi Visual cterm=reverse ctermbg=black

"### windows split ###
hi VertSplit ctermbg=none ctermfg=black
hi StatusLine ctermbg=green ctermfg=black
"hi StatusLineNC ctermfg=14 ctermbg=0
hi StatusLineNC ctermbg=grey ctermfg=black

"### search ###
"hi search cterm=reverse ctermfg=black
hi search ctermfg=14 ctermbg=black

"###################
"###   Mapping   ###
"###################

"Delay for key combination mapping
set timeoutlen=1000 ttimeoutlen=100

"global paperclip --> sudo apt-get install vim-gtk pour avoir ça dans la console sous ubuntu
noremap Y "+y
noremap YY "+yy
noremap P "+p

"mapleader sur espace
let mapleader = "\<space>"

"titre de la fenêtre hérite du titre du doc
set title
			
"Escape with kj (from insert and command line mode)  
inoremap jk <Esc>
cno jk <Esc>
vno v <Esc>
"Save with zs
noremap zs :w<CR>
noremap Z :w<CR>
noremap ZZ :x<CR>
noremap ZQ :q!<CR>
map zq :bd<CR>

"Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

noremap ù m
noremap m /
noremap M :
nmap <leader><leader> :nohl<CR>
nmap ! /
"marques
map è `

"point
"noremap ; .
"noremap . ;

"Envoyer à bash + log in .%_log
map gb :.w !bash
vmap gb :w !bash

map gbv :s/\#/\\#/ge<C-M>yy:s/\\#/\#/ge<C-M>:!vital '<C-R>"<C-H>'<Home><S-right>
vmap gbv :s/\#/\\#/ge<C-M>gvygv:s/\\#/\#/ge<C-M>:!vital '<C-R>"<C-H>'
"map gbv yy:!vital '<C-R>"<C-H>'

if filereadable("/bin/zsh")
	map gb :.w !zsh
	vmap gb :w !zsh
endif
"map gb yy:!echo "\# `date +\%A\ \%d\ \%B\ \%Y\ --\>\ \%kh\ \%Mm\ \%Ss`\n\# >>> <C-R>"<C-H>" >> .%_log<CR>:.w !bash\|tee -a .%_log
"vmap gb y:!echo "\# `date +\%A\ \%d\ \%B\ \%Y\ --\>\ \%kh\ \%Mm\ \%Ss`\n\# >>> <C-R>"<C-H><C-F>:.s/<C-V><C-M>/\\n\\# >>> /g<CR>A" >> .%_log<CR>:w !bash\|tee -a .%_log
map gbb yy:!echo "\# `date +\%A\ \%d\ \%B\ \%Y\ --\>\ \%kh\ \%Mm\ \%Ss`\n\# >>> <C-R>"<C-H>" >> .%_log<CR>:.w !bash>> .%_log<CR>
vmap gbb y:!echo "\# `date +\%A\ \%d\ \%B\ \%Y\ --\>\ \%kh\ \%Mm\ \%Ss`\n\# >>> <C-R>"<C-H><C-F>:.s/<C-V><C-M>/\\n\\# >>> /g<CR>A" >> .%_log<CR>:w !bash>> .%_log<CR>
map gB :w<CR>:e .%_log<CR>G
map gBB yy:w<CR>:e .%_log<CR>/<C-R>"<C-H><CR>

"Latex
"Envoyer à latex
map gl :w !pdflatex % & okular %<.pdf &
map gll :w !pdflatex --shell-escape --interaction=nonstopmode % ; bibtex %< ; pdflatex --shell-escape --interaction=nonstopmode % ; pdflatex --shell-escape --interaction=nonstopmode % 
map gL :w !pdflatex % & acroread %<.pdf &
map gLC :w !pdflatex % & chrome-bowser %<.pdf &

let g:tex_fold_enabled=0

"Envoyer à python
map gp :w !python3 %

"header
au BufNewFile *.py 0r ~/dotfiles/header.py

map gr :!R -e "library(knitr);spin('%')" && xdotool key alt+Tab && xdotool key ctrl+r && xdotool key alt+Tab


" fill rest of line with characters
function! FillLine( str, width )
    " set tw to the desired total length
    let tw = &textwidth
    let tw = a:width
    if tw==0 | let tw = 70 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

"-----  decoration code  ------------------------------------------------------
map g# ^ijkki################################################################################jkyyjpki@@@   jk$a   ####jkkld$jjld$kkVjjgh$j:.s/@/#/ge<CR>j$
map g& :s/#---* //ge<CR>:s/---*$//ge<CR>^ijkki################################################################################jkyyjpki@@@   jk$a   ####jkkld$jjld$kkVjjgh$j:.s/@/#/g<CR>j$
"map g- ^i----- <ESC>:call FillLine('-',70)<CR>gh$
"map gé ^i----- <ESC>:call FillLine('-',70)<CR>gh$
"map g" ^i------- jkgh^i   jk$
map gé k:s/####*//ge<CR>j:s/###   //ge<CR>:s/   ###//ge<CR>j:s/####*//ge<CR>k^i----- <ESC>:call FillLine('-',70)<CR>gh$
map g" ^i----- <ESC>gh^i <ESC>$

"map & 1
"map é 2
"map " 3
"map ' 4
"map ( 5
"map - 6
"map è 7
"map _ 8
"map ç 9
"map à 0

"ouvrir fichier sous curseur dans nouvel onglet
map gf :w<CR>:e <cfile><CR>
map gF :!gnome-open <cfile> <CR>

"view csv
map gc :set nowrap \| :%!column -t -s,<Enter>
map gcf :1split \| :set scrollopt=hor,jump \| :set scrollbind \| :wincmd j \| :set scrollbind<Enter>
map gC :set wrap \| :%s/ \+/,/g<Enter>

"view tsv
map gcsvt :set nowrap \| :%!column -t<Enter>
map gCSVT :set wrap \| :%s/ \+/\t/g<Enter>


" Change the color of the status line.
au InsertEnter * hi StatusLine term=reverse ctermbg=4
au InsertLeave * hi StatusLine term=reverse ctermbg=0 ctermbg=2

map <leader>lv :!ls > .lv<CR> :e .lv<CR>


"##################
"###   Plugin   ###
"##################

"mkdir -p ~/.vim/bundle
"git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
set nocompatible               " be iMproved
filetype off      " required!
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'ervandew/supertab'       
let g:SuperTabDefaultCompletionType = "context"

NeoBundle 'scrooloose/nerdtree'    
map gn :silent NERDTreeToggle <CR>

NeoBundle 'scrooloose/nerdcommenter'
map gh <leader>c<leader>

NeoBundle 'rhysd/clever-f.vim'
map ; f
map , F

NeoBundle 'jszakmeister/vim-togglecursor.git'

"NeoBundle 'vim-scripts/buftabs.git'
"let g:buftabs_only_basename=1
NeoBundle 'ap/vim-buftabline.git'
let g:buftabline_show=1
noremap <C-l> :bnext<CR> 
noremap <C-h> :bprev<CR>

"NeoBundle 'kien/ctrlp.vim'         
""map <C-b> :ls<CR>:b 
"map <C-b> :silent CtrlPMRU <CR>
"nmap <C-l> :silent CtrlPBuffer <CR>
"let g:ctrlp_clear_cache_on_exit=0
"let g:ctrlp_prompt_mappings = {
	"\ 'PrtSelectMove("j")': ['<tab>', '<down>', 'J', '<c-l>'],
	"\ 'PrtSelectMove("k")': ['<s-tab>', '<up>', 'K', '<c-h>'],
	"\ 'PrtCurLeft()': ['<c-m>'],
	"\ 'PrtCurRight()': ['<c-q>'],
	"\ }
"let g:ctrlp_match_window_reversed = 1 "CtrlP on top of screen

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
"call unite#custom#source('buffer,file,file_mru,file_rec','sorters', 'sorter_rank')
"map <C-l> :Unite -no-split -start-insert buffer<CR>
let g:unite_source_file_mru_long_limit = 5000000
let g:unite_source_directory_mru_long_limit = 5000
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
map <leader>u :<C-u>Unite -no-split -start-insert file_mru<CR>
map <leader>b :Unite -no-split -start-insert buffer<CR>
"map <C-l> :b <C-l><C-l>
"noremap <C-l> :bn<CR>
"nmap <C-l> :silent w<cr>:Unite -start-insert -no-split buffer<CR>
nmap <Leader><TAB> :ls<cr>:b 
"nmap <C-h> :silent w<CR>:b#<CR>
let g:unite_source_history_yank_enable = 1
nnoremap <Leader>p :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>
" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-l and control-h in insert mode
  imap <buffer> <C-l>  <Plug>(unite_select_next_line)
  imap <buffer> <C-h>  <Plug>(unite_select_previous_line)
endfunction

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }


NeoBundle 'MrJJJ/tslime.vim.git' 

"NeoBundle 'benmills/vimux.git'
"function! VimuxSlime()
  "call VimuxSendText(@v)
  "call VimuxSendKeys("Enter")
"endfunction

 " If text is selected, save it in the v buffer and send that buffer it to tmux
 vmap <leader>t "vy :call VimuxSlime()<CR>

 " Select current paragraph and send it to tmux
 nmap <leader>tt vip<LocalLeader>vs<CR>

"Not fully supported by vundle
"cd ~/.vim/plugin && ln -s ~/.vim/bundle/tslime.vim/tslime.vim
"NeoBundle 'MrJJJ/csv.vim.git'
	"hi default CSVColumnHeaderEven term=bold guibg=none
	"hi default CSVColumnHeaderOdd term=bold guibg=none
	"hi default CSVColumnEven term=bold guibg=none
	"hi default CSVColumnOdd term=bold guibg=none
	"hi default CSVDelimiter term=bold guibg=none
	"let g:csv_no_conceal=1
	"nmap gcsv :%ArrangeColumn<CR>

"NeoBundle 'Lokaltog/vim-powerline.git'
"let g:Powerline_symbols='fancy'
"let g:Powerline_colorsheme = 'solarized256'
"NeoBundle 'bling/vim-airline.git'
"let g:airline#extensions#tabline#enabled = 1

NeoBundle 'davidhalter/jedi.git'

NeoBundle 'tpope/vim-fugitive'
map <leader>gg :!git add %<CR> :Gcommit<CR>i
map <leader>gp :Git push<CR>

NeoBundle 'tpope/vim-obsession.git'
"fu! SaveSess()
	 "execute 'silent Obsession .'
"endfunction
"autocmd BufWritePost * call SaveSess()
map <leader>o :Obsession<CR>

NeoBundle 'tpope/vim-surround.git'

"NeoBundle 'SirVer/ultisnips.git'
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="g<tab>"
"let g:UltiSnipsJumpBackwardTrigger="g<s-tab>"
""stuff to define my own snippets
"set runtimepath+=~/.vim/bundle
"let g:UltiSnipsSnippetDirectories=["UltiSnips","snippets"]

NeoBundle 'MrJJJ/snippets.git'

NeoBundle 'vim-scripts/Vim-R-plugin.git'
let vimrplugin_assign = 1
let vimrplugin_screenplugin = 0
"NeoBundle 'Valloric/YouCompleteMe.git'

NeoBundle "godlygeek/tabular.git"
map <leader>t, :Tabularize /,<CR>

NeoBundle "majutsushi/tagbar"
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }


NeoBundle 'osyo-manga/vim-over'
let g:over_enable_auto_nohlsearch = 1
let g:over_enable_cmd_window = 1

"NeoBundle 'justinmk/vim-sneak.git'
"hi SneakPluginTarget guifg=black guibg=red ctermfg=black ctermbg=red

filetype plugin indent on     " Required!

 " Installation check.
NeoBundleCheck


"Ctag et taglist
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"filetype on
""lorsque j'appuie sur F12 -> lancer la commande :TlistToggle
"nnoremap <silent> <F11> :TlistToggle<CR> 
"nnoremap <silent> <F12> :TlistOpen<CR> 
"let Tlist_Process_File_Always = 1 "Laisser activer le plugin en permanence
"set statusline=%<%f%=%([%{Tlist_Get_Tagname_By_Line()}]%)
"let Tlist_Exit_OnlyWindow = 1
"" prérequis tags
"set nocp
"filetype plugin on

"For Konsole
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"xterm
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"if has("autocmd")
	"au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Profile1/cursor_shape ibeam"
	"au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Profile1/cursor_shape block"
    "au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Profile1/cursor_shape block"
    "endif
	"
"
""Pour urxvt
"silent !echo -ne "\033]12;white\007"    " Initialize the cursor to white at startup
""let &t_SI = "\033]12;green\007" " Turn the cursor green when entering insert mode
"let &t_EI = "\033]12;white\007" " Turn the cursor white again when leaving insert mode
"autocmd VimLeave * !echo -ne "\033]12;white\007"    " Make sure the cursor is back to white when Vim exits

"if &term =~ '^xterm'
   "solid underscore
  "let &t_SI .= "\<Esc>[5 q"
	   "" solid block
	 "let &t_EI .= "\<Esc>[2 q"
		   "" 1 or 0 -> blinking block
			 "" 3 -> blinking underscore
			   "" Recent versions of xterm (282 or above) also support
				 "" 5 -> blinking vertical bar
				   "" 6 -> solid vertical bar
   "endif
   "
  
"###########################
"###   TOGGLE SETTING   ###
"###########################
nmap <leader>ss :set spell!<CR>
nmap <leader>sl :set list!<CR>
nmap <leader>sz :set lazyredrawn!<CR>
nmap <leader>sw :set wrap!<CR>
nmap <leader>sp :set paste!<CR>
nmap <leader>si :set ic!<CR>
nmap <leader>swp :!rm ~/.vim/bck/*%*.swp


"###################
"###   MAPPING   ###
"###################

"############################
"###   LAST TO EXECUTE   ####
"############################

"Disctinction between folding title and normal comments
au BufRead,BufNewFile * hi Comment ctermfg=cyan
au BufRead,BufNewFile * hi title ctermfg=blue
au BufRead,BufNewFile * syn match title /^\s*#.*$/
