###################
###   #PROMPT   ###
###################
autoload -U colors && colors
export PS1="%{$fg[yellow]%}[%n@%M:%~]$ %{$reset_color%}"
vital=vital-it
host=$HOST
if [ "${host/vital}" = "$host" ]
then
	export PS1="%{$fg[yellow]%}[%n@%M:%~]$ %{$reset_color%}"
else
	export PS1="%{$fg[yellow]%}[%n@%{$fg[red]%}%M%{$fg[yellow]%}:%~]$ %{$reset_color%}"
fi

#################
###   Pager   ###
#################
export PAGER=less

###################
###   #VIMODE   ###
###################
bindkey -v
bindkey jk vi-cmd-mode
bindkey -s kk "\ntmux copy-mode\n"
VIMODE='[i]'
#gestion touche backspace (et autre) et vi mode
bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" backward-kill-line    # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char
bindkey '^R' history-incremental-search-backwardk
bindkey '^[[7~' beginning-of-line #touche home
bindkey '^[[8~' end-of-line #touche Fin
bindkey '^D'    delete-char             # Del
bindkey "^[[3~" delete-char # la touche suppr
autoload zsh-history-substring-search
zle -N zsh-history-substring-search
bindkey "^T" zsh-history-substring-search #PgUp

####################
###   #HISTORY   ###
####################
HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.zsh_history
#Partager historique ?
setopt histignorealldups sharehistory
setopt AUTO_CD # pas besoin d'écrire cd pour aller dans dossier

###########################
###   VARIOUS OPTIONS   ###
###########################
# Report CPU usage for commands running longer than 10 seconds
REPORTTIME=10
set -k #Treat # as comments

#######################
###   #COMPLETION   ###
#######################
autoload -Uz compinit
compinit
setopt complete_in_word

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=1
#eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

#zsh completion on scp ssh sftp
echo 'HashKnownHosts no' > ~/.ssh/config
if [ -f ~/.ssh/known_hosts ]; then
zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
zstyle ':completion:*:*:(ssh|scp|sftp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`
fi

#unsetopt list_ambiguous #Faire qu'au premier tab il y est la liste de toutes les possibilités+partie commune puis rotation entre elles

#Autocorrection
setopt correctall

bindkey -M viins ^R history-incremental-pattern-search-backward

setopt extendedglob


####################
###   #ALIASES   ###
####################
#if [ -x /usr/bin/dircolors ]; then
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -lh --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

	alias xclip='xclip -selection "clipboard"'
	alias ld='ls --color=auto -d */'

	alias t='task'
	alias tn='task note'

	alias td='todo -Ac'
	alias grep='grep --color=auto'

	alias c='clear'
	alias s='cd ..'
#fi

#Open all filenames in vim
function lv() {ls "$@" | vim - -c ":w! .lv" ;} #ouvrir un ls dans vim

#Archive
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

####################################
###   # VARIABLE ENVIRONNEMENT   ###
####################################
export PYTHONPATH=/home/$USER/jpy
export PATH=$PATH:$HOME/bin/

#######################
###   #TMUX STUFF   ###
#######################
alias tmux='TERM=xterm-256color tmux'
[[ $TERM != "screen-256color" ]] # && tmux #&& exit

alias ,='tmux rename-window ${PWD##*/}'


#Completion in current tmux pane
# Autocomplete from current tmux screen buffer
_tmux_pane_words() {
  local expl
  local -a w
  if [[ -z "$TMUX_PANE" ]]; then
    _message "not running inside tmux!"
    return 1
  fi
  w=( ${(u)=$(tmux capture-pane \; show-buffer \; delete-buffer)} )
  _wanted values expl 'words from current tmux pane' compadd -a w
}
zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^X' tmux-pane-words-prefix
#bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'

#tmux rename windows
f(){ if [ "$PWD" != "$LPWD" ];then LPWD="$PWD"; tmux rename-window ${PWD//*\//}; fi }; export PROMPT_COMMAND=f;


##########################
###   	#HANDY TOOLS   ###
##########################
#autojump
#git clone https://github.com/joelthelion/autojump.git
#Run the installation script:
#cd autojump
#./install.sh [ --local ]
[[ -f ~/.autojump/etc/profile.d/autojump.zsh ]] && source ~/.autojump/etc/profile.d/autojump.zsh

#Print 256 colors
col256()
{
( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
for i in {0..256};
do
o=00$i;
echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
done )
}

li() # ls and ignore a pattern
{
if [ ! -f .li ]
then
	echo "Pattern to ignore ?"
	read newPattern
	echo $newPattern > .li
fi
pattern=`cat .li`
ls -I$pattern
}

#xcape
#sudo apt-get install git gcc make libx11-dev libxtst-dev pkg-config
#mkdir ~/source/xcape
#cd ~/source/xcape
#git clone https://github.com/alols/xcape.git .
#make
#cp xcape ~/bin
if hash xcape 2>/dev/null; then
if [ -z $XCAPE ] ; then
	export XCAPE=1
	killall xcape
	xcape -e 'Caps_Lock=Escape'
	#xcape -e 'Caps_Lock=Escape;space=ISO_Group_Shift'
fi
fi

#plugin from https://github.com/zsh-users/zsh-history-substring-search
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh-history-substring-search.zsh
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bold,underline"

#source ~/.zsh-autosuggestions/autosuggestions.zsh
## Enable autosuggestions automatically
#zle-line-init() {
	#zle autosuggest-start
#}
#zle -N zle-line-init
## use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
## zsh-autosuggestions is designed to be unobtrusive)
#bindkey '^T' autosuggest-toggle
#bindkey '^f' vi-forward-word
#```
#

#########################################
###   Very specific stuff for ultra   ###
#########################################
#~/bin/retmuxJJJ && clear
