#ヾ(๑╹◡╹)ﾉ < loading zshrc...
# ----------------------------------------
# Author: Rintaro Okamura
# URL:    http://rinx.biz
# Source: https://github.com/rinx/dotfiles
# ----------------------------------------


#basic settings for zsh

autoload -U compinit
compinit

#highlight for completion
zstyle ':completion:*:default' menu select=2 

#completion settings
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#separators for completion
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

autoload colors
colors

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

#vimlike keybind
bindkey -v 

#export LANG=ja_JP.UTF-8

case ${UID} in
0)
    LANG=C
	;;
esac

case "${TERM}" in
kterm*|xterm)
    precmd() {
	    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	}
	;;
esac


HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

bindkey "^R" history-incremental-search-backward
bindkey "^E" history-incremental-search-forward

setopt auto_cd
setopt auto_pushd

setopt correct
setopt list_packed
setopt nolistbeep

setopt prompt_subst
setopt transient_rprompt

setopt auto_list
setopt auto_menu

setopt auto_param_slash
setopt auto_param_keys

setopt correct


#prompt settings

#prompt

local lf=$'\n'

local afterhost=''

# when connected to remote host
if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
    local usrathn="%F{yellow}%n@$HOST%f"
    if [ ${#HOST} -gt 10 ]; then
        local afterhost="$lf"
    fi
else
    local usrathn="%n"
fi

local plat='%(?.%F{green}[%~]%f.%F{red}[%~]%f)'
local pbase="%F{cyan}[$usrathn%F{cyan}]%f$afterhost$plat"
local pbase_nor="%F{red}[$usrathn%F{red}]%f$afterhost$plat"

PROMPT="%5(~|$pbase$lf|$pbase)%% "

##zsh vi-like keybind mode indicator
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
            PROMPT="%5(~|$pbase_nor$lf|$pbase_nor)%% "
        ;;
        main|viins)
            PROMPT="%5(~|$pbase$lf|$pbase)%% "
        ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


#for, while, etc...
PROMPT2="%5(~|$pbase$lf|$pbase)%F{yellow}%_%f> " 

#missing spell
SPROMPT="%F{yellow}(っ'ヮ'c) < Did you mean %r?[n,y,a,e]:%f "


#git statuses for Right Prompt
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color gitdir action start_time
  start_time=$SECONDS
  if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  # when this script requires long time to run,
  # please, execute follow command.
  #    $ touch .git/rprompt-nostatus
  if [[ -e "$gitdir/rprompt-nostatus" ]]; then
      echo "[ ${name}${action}]"
      return
  fi

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
    color=%F{red}
  fi

  # when this script requires long time to run, do not show color again
  if [[ $(($SECONDS - $start_time)) -gt 3 ]]; then
    echo "test"
    touch $gitdir/rprompt-nostatus
  fi

  echo "${color}[ ${name}${action}]%f%b "
}

RPROMPT='`rprompt-git-current-branch`'


#Banner

[ -f ~/.archey ] && python ~/.archey

#zsh-autosuggestions

ZSH_HOME=$HOME/.zsh

if [ -d $ZSH_HOME/zsh-autosuggestions ]; then
    source $ZSH_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    if builtin command -v git > /dev/null 2>&1 ; then
        mkdir -p $ZSH_HOME
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_HOME/zsh-autosuggestions
        source $ZSH_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi
fi

#alias settings

alias rm='rm -i'
alias mv='mv -i'
alias rr='rm -ri'
alias rrf='rm -rf'

#cd
alias u='cd ../'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias uuuu='cd ../../../../'
alias cdr='cd -'

if ls --color > /dev/null 2>&1 ; then
    alias ls='ls --color -F'
    alias lsa='ls --color -F -a'
    alias lsl='ls --color -F -l'
    alias lsal='ls --color -F -a -l'
else # for BSD version
    alias lsa='ls -a'
    alias lsl='ls -l'
    alias lsal='ls -al'
fi

#start vim as vi
alias vi='vimswitcher'
alias tinyvim='vim -u ~/.dotfiles/tiny.vimrc'

alias be='bundle exec'

alias q='exit'

#grep
if echo a | grep --color a > /dev/null 2>&1 ; then
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
fi

#global
alias -g @l='| less'
alias -g @h='| head'
alias -g @t='| tail'
alias -g @g='| grep'

#pandoc with lualatex
if builtin command -v pandoc > /dev/null 2>&1 ; then
    if buildin command -v lualatex > /dev/null 2>&1 ; then
        alias pandoclt='pandoc -V documentclass=ltjarticle --latex-engine=lualatex'
    fi
fi

#hub aliasing (https://github.com/defunkt/hub)
if builtin command -v hub > /dev/null 2>&1 ; then
    function git() {hub "$@"}
fi

#extract
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1   ;;
            *.tar.gz)    tar xvzf $1   ;;
            *.tar.xz)    tar xvJf $1   ;;
            *.bz2)       bunzip2  $1   ;;
            *.rar)       unrar x  $1   ;;
            *.gz)        gunzip   $1   ;;
            *.tar)       tar xvf  $1   ;;
            *.tbz2)      tar xvjf $1   ;;
            *.tgz)       tar xvzf $1   ;;
            *.zip)       unzip    $1   ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x     $1   ;;
            *.lzma)      lzma -dv $1   ;;
            *.xz)        xz -dv   $1   ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

#for git aliases
alias gst='git status -s -b && git stash list'
gsta () {
    if [ $# -eq 1 ]; then
        git add `git status -s -b | grep -v "^#" | awk '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
    else
        echo "invalid arguments"
    fi
}
gstd () {
    if [ $# -eq 1 ]; then
        git diff -- `git status -s -b | grep -v "^#" | awk '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
    else
        echo "invalid arguments"
    fi
}
gstv () {
    if [ $# -eq 1 ]; then
        vim `git status -s -b | grep -v "^#" | awk '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
    else
        echo "invalid arguments"
    fi
}
gcm () {
    git commit -m "$*"
}
gbr () {
    if [ $# -eq 0 ]; then
        git branch
    elif [ $# -eq 1 ]; then
        git checkout `git branch | sed "s/\*//g" | sed "s/^\ *//g" | awk "NR==$1"`
    else
        echo "invalid arguments"
    fi
}
alias gtl='git l'


# vim / neovim auto-switcher
vimswitcher () {
    case $1 in
        *.vim)   nvim $1 ;;
        *.hs)    nvim $1 ;;
        *.rs)    nvim $1 ;;
        *.py)    nvim $1 ;;
        *.rb)    nvim $1 ;;
        *.txt)   vim $1  ;;
        *.tex)   vim $1  ;;
        *.md)    vim $1  ;;
        *.elm)   nvim $1 ;;
        *.clj)   nvim $1 ;;
        *.go)    nvim $1 ;;
        *)       nvim $1 ;;
    esac
}


