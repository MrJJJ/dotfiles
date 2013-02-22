set nocompatible
										
"Si vous voulez utiliez les CTRL+C, CTRL+V, ...
"source $HOME/.vim/mswin.vim
"Sinon vous pouvez toujours utiliser une version minimale qui surcharge juste
"les CTRL+... vraiment utiles : récupérez les lignes qui vous intéressent dans
"ce mswin.vim.

"Activation de la coloration et de l'intendation
syn on
set syntax=on
syntax enable
"colorscheme 256_jungle
filetype indent on
filetype plugin on
set autoindent
colorscheme default
set t_Co=256
set runtimepath+=/usr/share/vim/addons/

"working directory same as file you are editing
set autochdir

"Afficher les n° de ligne
set nu

"Activer la souris dans vim (dans gvim elle est déjà active)
set mouse=a
set mouse=r


"Afficher les parenthèses correspondantes
set showmatch
set showcmd "voir les commandes que je tappe


"Modifier la police
set guifont=Courier\ 12

"Modifier la taille des tabulations
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set expandtab "supprime les tabulations et met des espaces

"Recherche
set incsearch
"set ignorecase
"set smartcase

"Complétion
set wmnu "affiche le menu
set wildmode=list:longest,list:full "affiche toutes les possibilités
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz "ignorer certains types de fichiers pour la complétion des includes
imap <Tab> <C-X><C-F>

"Folding
set foldmethod=indent "va fold selon indentation
"set foldmethod=syntax "va fold selon la syntaxe
set foldlevel=99 "ouvre les folds jusqu'au niveau demandé (99=tous)
function! MyFoldFunction()
	let line = getline(v:foldstart)
	let sub = substitute(line,'/\*\|\*/\|^\s+', '', 'g')
	let lines = v:foldend - v:foldstart + 1
	return v:folddashes.sub.'...'.lines.' Lines...'.getline(v:foldend)
endfunction
"set foldmethod=syntax "Réduira automatiquement les fonctions et blocs (#region en C# par exemple)
"set foldtext=MyFoldFunction() "on utilise notre fonction (optionnel)


"Orthographe
"set spelllang=en,fr
"set spell
"set spellsuggest=5

"Afficher la ligne du curseur
"set cursorline 

imap <C-Space> <C-X><C-O>
iab #i #include


set autoindent "Auto-indentation

set incsearch     "Recherche par incrémentation
"set hlsearch
"autocmd InsertEnter * :let @/=""
"autocmd InsertLeave * :let @/=""

set backup "Active le backup de vos fichiers en cas de plantage
set backupdir=$HOME/.vimbackup "Le dossier où seront placés vos backup

"set scrolloff=5 "Keeps cursor x lines from the bottom of the screen


"SYNTAX HILIGHT
"ouvrir les fichiers word et openoffice
au BufReadCmd *.docx,*.xlsx,*.pptx call zip#Browse(expand("<amatch>"))
au BufReadCmd *.odt,*.ott,*.ods,*.ots,*.odp,*.otp,*.odg,*.otg call zip#Browse(expand("<amatch>"))
"gerer le *.R
au BufRead,BufNewFile *.R set filetype=r 
au BufRead,BufNewfile *.fas set filetype=align
au BufRead,BufNewfile *.fasta set filetype=align
au BufRead,BufNewfile *.tex set filetype=tex

set dictionary+=/usr/share/dict/american-english
imap <C-b> <C-x><C-k><C-n>




"Ctag et taglist
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
filetype on
"lorsque j'appuie sur F12 -> lancer la commande :TlistToggle
nnoremap <silent> <F11> :TlistToggle<CR> 
nnoremap <silent> <F12> :TlistOpen<CR> 
let Tlist_Process_File_Always = 1 "Laisser activer le plugin en permanence
set statusline=%<%f%=%([%{Tlist_Get_Tagname_By_Line()}]%)
let Tlist_Exit_OnlyWindow = 1
" prérequis tags
set nocp
filetype plugin on
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

"naviguer entre onglet en faisant Ctrl+haut et Ctrl+bas plutôt que gt et gT
noremap <C-down> gt
noremap <C-up> gT
"naviguer entre fenêtres
noremap <S-W> <C-W>

nnoremap & :'{,'}s/<c-r>=expand('<cword>')<cr>/

"Permettre d'ouvrir plus d'onglets qu'autorisé
set tabpagemax=50


"AUTOCOMPLETION avec tab
"Use TAB to complete when typing words, else inserts TABs as usual.
""Uses dictionary and source files to find matching words to complete.

"See help completion for source,
""Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
""Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
""function! Tab_Or_Complete()
""	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
""		return "\<C-N>"
""	else
""		return "\<Tab>"
""	endif
""endfunction
"":inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
"":set dictionary="/usr/dict/words"
""
let g:SuperTabDefaultCompletionType = "context"


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

"auto close bracket
":inoremap ( ()<Esc>i
":inoremap " ""<Esc>i
":inoremap [ []<Esc>i

"global paperclip --> sudo apt-get install vim-gtk pour avoir ça dans la console sous ubuntu
noremap Y "+y
noremap YY "+yy
noremap P "+p

"mapleader sur espace (commenter en faisant space c space avec nerdcommenter)
let mapleader = " "

"titre de la fenêtre hérite du titre du doc
set title
			
"Escape with kj (from insert and command line mode)  
inoremap jj <Esc>
inoremap kk <Esc>
inoremap jk <Esc>
cno jj <Esc>
vno v <Esc>
"Save with zs
noremap zs :w<CR>
noremap <C-h> b
noremap <C-l> w

set pastetoggle=<F3>

"syntax color
hi Statement ctermfg=yellow

"Peaufinement esthétique des onglets
hi TabLineFill cterm=bold
hi TabLineFill ctermbg=0
hi TabLine ctermfg=0
hi TabLine cterm=none
hi TabLine cterm=reverse
hi TabLineSel ctermbg=0
hi TabLineSel ctermfg=yellow
hi TabLineSel ctermfg=3
"Peaufinement esthétique des replis
hi Folded ctermfg=cyan ctermbg=black
"Peaufinement esthétique pour popup completion
hi Pmenu ctermbg=black
hi Pmenu ctermfg=darkcyan
hi PmenuSel ctermfg=yellow ctermbg=black
hi PmenuSbar ctermfg=black ctermbg=black
"Peaufinement des line number
"hi LineNr ctermfg=65
hi LineNr ctermfg=14
hi SpellBad ctermbg=none ctermfg=red
"Peaufinement esthétique des match parenthesis
hi MatchParen cterm=bold ctermfg=yellow ctermbg=darkblue
"Peaufinement esthétique du visual mode 
hi Visual cterm=reverse ctermbg=black
"Peaufinement esthétique des windows split 
hi VertSplit ctermbg=none ctermfg=black
hi StatusLine ctermfg=black ctermbg=green
hi StatusLineNC ctermfg=black ctermbg=white

"persistent undo
set undofile
set undodir=$HOME/.vim/undo
set undolevels=100

"marques
map è `

"point
noremap ; .
noremap . ;

"Envoyer à bash
map gb :.w !bash
vmap gb :w !bash

"Latex
"Envoyer à latex
map gl :w !pdflatex % & okular %<.pdf &
map gll :w !pdflatex --shell-escape --interaction=nonstopmode % ; bibtex %< ; pdflatex --shell-escape --interaction=nonstopmode % ; pdflatex --shell-escape --interaction=nonstopmode % 
map gL :w !pdflatex % & acroread %<.pdf &
map gLC :w !pdflatex % & chrome-bowser %<.pdf &

let g:tex_fold_enabled=0

"Envoyer à python
map gp :w !python3.2 %

"Commenter
map gh :.s/^/#/g <Enter>
vmap gh :s/^/#/g <Enter>
map gH :.s/^#//g <Enter>
vmap gH :s/^#//g <Enter>

map g/ :.s/^/\/\//g <Enter>
vmap g/ :s/^/\/\//g <Enter>
map g: :.s/^\/\///g <Enter>
vmap g: :s/^\/\///g <Enter>

map g# ^ijkki################################################################################jkyyjpki###   jk$a   ###jkkld$jjld$

map ''' bi'jkeai'jk 
map """ bi"jkeai"jk 
map ((( bi(jkeai)jkF(
map {{{ bi{jkeai}jkF{ 
map [[[ bi[jkeai]jkF[ 


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
map gf <C-w>gf
map gF :!gnome-open <cfile> <CR>
map zqq :tabdo q!

"view csv
map gc :set nowrap \| :%!column -t -s,<Enter>
map gC :set wrap \| :%s/ \+/,/g<Enter>

"view tsv
map gcsvt :set nowrap \| :%!column -t<Enter>
map gCSVT :set wrap \| :%s/ \+/\t/g<Enter>

"Turn of scrolling (fastier)
"set ttyscroll=0
"Have a fast terminal conection
set ttyfast
"Make the status line a little bit more informative.
"
"" Make the status line a little bit more informative.
set statusline=%F%m%r%h%w\ [%p%%]\ <Format=%{&ff}>\ <Type=%Y>\ <%04l,%03v>

" Change the color of the status line.
au InsertEnter * hi StatusLine term=reverse ctermbg=4
au InsertLeave * hi StatusLine term=reverse ctermbg=0 ctermbg=2



""Vundle -> manage vim bundle
""git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
 set nocompatible               " be iMproved
 filetype off                   " required!
"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdtree'
map gh <leader>c<leader>
Bundle 'scrooloose/nerdcommenter'
map gn :silent NERDTreeToggle <CR>
Bundle 'kien/ctrlp.vim'
map <C-b> :silent CtrlPBuffer <CR>
let g:ctrlp_prompt_mappings = {
      \ 'PrtSelectMove("j")': ['<c-j>', '<down>', 'J'],
      \ 'PrtSelectMove("k")': ['<c-k>', '<up>', 'K'],
      \ 'PrtHistory(-1)': ['<c-n>'],
      \ 'PrtHistory(1)': ['<c-p>'],
      \ 'ToggleFocus()': ['<c-i>'],
      \ }
let g:ctrlp_match_window_reversed = 0 "CtrlP on top of screen
"Bundle 'hsitz/VimOrganizer.git'
Bundle 'kikijump/tslime.vim.git' 
"Not fully supported by vundle
"cd ~/.vim/plugin && ln -s ~/.vim/bundle/tslime.vim/tslime.vim
Bundle 'kakkyz81/evervim.git'
"let g:evervim_devtoken='S=s6:U=d1042:E=1443bcc495e:C=13ce41b1d5f:P=1cd:A=en-devtoken:H=010e07ce2cf08e48fd0863997c293964'
 
 "Bundle 'tpope/vim-fugitive'
 "Bundle 'Lokaltog/vim-easymotion'
 "Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
 "Bundle 'tpope/vim-rails.git'
 " vim-scripts repos
" Bundle 'L9'
 "Bundle 'FuzzyFinder'
 " non github repos
 "Bundle 'git://git.wincent.com/command-t.git'
 " ...
 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..



"xterm
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"if has("autocmd")
	"au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Profile1/cursor_shape ibeam"
	"au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Profile1/cursor_shape block"
    "au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Profile1/cursor_shape block"
    "endif
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
