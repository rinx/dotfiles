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

