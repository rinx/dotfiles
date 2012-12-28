
autoload -U compinit
compinit

bindkey -v

export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
	;;
esac

#load prompt settings
source ~/.dotfiles/zsh.d/prompt.zsh

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

#virtualenvwrapper.sh呼出
if [ -f /bin/virtualenvwrapper.sh ]; then
	export WORKON_HOME=$HOME/.virtualenvs
	source /bin/virtualenvwrapper.sh
fi

#banner
source ~/.dotfiles/zsh.d/banner.zsh

#alias settings
source ~/.dotfiles/zsh.d/alias.zsh


