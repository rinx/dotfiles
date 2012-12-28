#basic settings for zsh

autoload -U compinit
compinit

#vimlike keybind
bindkey -v 

export LANG=ja_JP.UTF-8

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
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups
setopt share_history

#auto_cd
setopt auto_cd
setopt auto_pushd

setopt correct
setopt list_packed
setopt nolistbeep

#autoload predict-on
#predict-on


