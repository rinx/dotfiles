# ----------------------------------------
# Author: Rintaro Okamura
# URL:    http://rinx.biz
# Source: https://github.com/rinx/dotfiles
# ----------------------------------------

OS=$(uname -s)

autoload -U compinit
compinit

# highlight for completion
zstyle ':completion:*:default' menu select=2 

# completion settings
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# separators for completion
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

autoload colors
colors

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# vimlike keybind
bindkey -v 

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


# prompt

local lf=$'\n'

local afterhost=''

# when connected to remote host
if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
    local usrathn="%F{yellow}%n@$HOST%f"
    if [ ${#HOST} -gt 10 ]; then
        local afterhost="$lf"
    fi
elif [ -n "${DOCKERIZED_DEVENV}" ]; then
    local usrathn="%F{yellow}%n@${DOCKERIZED_DEVENV}%f"
    if [ ${#DOCKERIZED_DEVENV} -gt 10 ]; then
        local afterhost="$lf"
    fi
else
    local usrathn="%n"
fi

local plat='%(?.%F{green}[%~]%f.%F{red}[%~]%f)'
local pbase="%F{cyan}[$usrathn%F{cyan}]%f$afterhost$plat"
local pbase_nor="%F{red}[$usrathn%F{red}]%f$afterhost$plat"

PROMPT="%5(~|$pbase$lf|$pbase)%% "

# zsh vi-like keybind mode indicator
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


# for, while, etc...
PROMPT2="%5(~|$pbase$lf|$pbase)%F{yellow}%_%f> " 

# missing spell
SPROMPT="%F{yellow}(っ'ヮ'c) < Did you mean %r?[n,y,a,e]:%f "

function precmd() {
    if [ ! -z $TMUX ]; then
        tmux refresh-client -S
    fi
}


# zplug
export ZPLUG_HOME=$HOME/.zplug

if builtin command -v git > /dev/null 2>&1 ; then
    if [ ! -f $ZPLUG_HOME/init.zsh ]; then
        git clone https://github.com/zplug/zplug $ZPLUG_HOME
    fi

    source $ZPLUG_HOME/init.zsh

    zplug 'zplug/zplug', hook-build:'zplug --self-manage'

    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions", as:plugin, use:"src"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "zsh-users/zsh-history-substring-search"

    (type fzf > /dev/null 2>&1) || zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
    (type fzf-tmux > /dev/null 2>&1) || zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

    if [[ "$OS" == "Darwin" ]]; then
        (type exa > /dev/null 2>&1) && alias ls=exa || zplug "ogham/exa", as:command, from:gh-r, use:"*macos-x86_64*", rename-to:ls
        (type rg > /dev/null 2>&1) || zplug "BurntSushi/ripgrep", as:command, from:gh-r, use:"*x86_64*darwin*", rename-to:rg
        (type bat > /dev/null 2>&1) || zplug "sharkdp/bat", as:command, from:gh-r, use:"*x86_64*darwin*", rename-to:bat
        (type fd > /dev/null 2>&1) || zplug "sharkdp/fd", as:command, from:gh-r, use:"*x86_64*darwin*", rename-to:fd
    else
        (type exa > /dev/null 2>&1) && alias ls=exa || zplug "ogham/exa", as:command, from:gh-r, use:"*linux-x86_64*", rename-to:ls
        (type rg > /dev/null 2>&1) || zplug "BurntSushi/ripgrep", as:command, from:gh-r, use:"*x86_64*linux*", rename-to:rg
        (type bat > /dev/null 2>&1) || zplug "sharkdp/bat", as:command, from:gh-r, use:"*x86_64*linux*musl*", rename-to:bat
        (type fd > /dev/null 2>&1) || zplug "sharkdp/fd", as:command, from:gh-r, use:"*x86_64*linux*musl*", rename-to:fd
    fi

    (type ghq > /dev/null 2>&1) || zplug "motemen/ghq", from:gh-r, as:command, rename-to:ghq
    (type jq > /dev/null 2>&1) || zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq

    (type xpanes > /dev/null 2>&1) || zplug "greymd/tmux-xpanes"

    if ! zplug check --verbose; then
        zplug install
    fi

    zplug load
fi


# aliases

alias rm='rm -i'
alias mv='mv -i'
alias rr='rm -ri'
alias rrf='rm -rf'

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

# start vim as vi
if builtin command -v vim > /dev/null 2>&1 ; then
    alias vi='vimswitcher'
    alias tinyvim='vim -u ~/.dotfiles/tiny.vimrc'
fi

alias lightvim='nvim -u ~/.dotfiles/light.vimrc'
alias lvim=lightvim

# Macvim
if [ -d /Applications/MacVim.app/ ]; then
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
    alias vimdiff='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/vimdiff'
    alias view='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/view'
    alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim'
fi

alias q='exit'

# grep
if builtin command -v grep > /dev/null 2>&1 ; then
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
fi

if builtin command -v rg > /dev/null 2>&1 ; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
fi

if builtin command -v fzf > /dev/null 2>&1 ; then
    export FZF_DEFAULT_OPTS="--ansi --select-1 --exit-0 --height 40% --reverse --cycle --border"
    if [ ! -z $TMUX ]; then
        if builtin command -v fzf-tmux > /dev/null 2>&1 ; then
            alias fzf=fzf-tmux
        fi
    fi

    fh() {
        print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
    }

    fcd() {
        local dir
        dir=$(find ${1:-.} -path '*/\.*' -prune \
            -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
    }

    fcda() {
        local dir
        dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
    }

    fps() {
        ps -ef | sed 1d | fzf -m
    }

    fkill() {
        local pid
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

        if [[ "x$pid" != "x" ]] ; then
            echo $pid | xargs kill -${1:-9}
        fi
    }

    fgbr() {
        local branches branch
        branches=$(git branch --all | grep -v HEAD) &&
            branch=$(echo "$branches" |
            fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
            git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    }

    fgshow() {
        git log --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
            fzf --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
            --bind "ctrl-m:execute:
        (grep -o '[a-f0-9]\{7\}' | head -1 |
            xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
        {}
        FZF-EOF"
    }

    fgstash() {
        local out
        out=$(git stash list --pretty="%gd %C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" \
            | fzf --ansi --no-sort --query="$q" --print-query \
            --preview 'echo {} | cut -d " " -f 1 | xargs -I % git stash show -p %')

        if [[ "$out" != "" ]] ; then
            echo $out
            echo $out | cut -d " " -f 1 | xargs -I % git stash pop %
        fi
    }

    fprev() {
        fzf --preview 'head -100 {}'
    }

    if builtin command -v ghq > /dev/null 2>&1 ; then
        fghq() {
            local dir
            dir=$(ghq list | fzf +m)
            if [[ "$dir" != "" ]]; then
                cd "`ghq root`/$dir"
            fi
        }
    fi

    if [ ! -z $TMUX ] ; then
        ftp() {
            local panes current_window current_pane target target_window target_pane
            panes=$(tmux list-panes -s -F '#I:#P - #{window_name} #{pane_current_path} #{pane_current_command}')
            current_pane=$(tmux display-message -p '#I:#P')
            current_window=$(tmux display-message -p '#I')

            target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

            target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
            target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

            if [[ $current_window -eq $target_window ]]; then
                tmux select-pane -t ${target_window}.${target_pane}
            else
                tmux select-pane -t ${target_window}.${target_pane} &&
                    tmux select-window -t $target_window
            fi
        }
    fi
fi

# xsel (linux only)
if builtin command -v xsel > /dev/null 2>&1 ; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

# pandoc with lualatex
if builtin command -v pandoc > /dev/null 2>&1 ; then
    if buildin command -v lualatex > /dev/null 2>&1 ; then
        alias pandoclt='pandoc -V documentclass=ltjarticle --latex-engine=lualatex'
    fi
fi

# hub aliasing (https://github.com/defunkt/hub)
if builtin command -v hub > /dev/null 2>&1 ; then
    function git() {hub "$@"}
fi

# git aliases
alias gst='git status -s -b && git stash list'

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

# extract
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

# clojure
# (please refer `deps.edn`)
if builtin command -v rlwrap > /dev/null 2>&1 ; then
    alias cljdev='clj -A:dev -r'
else
    alias cljdev='clojure -A:dev -r'
fi

# docker
alias devstart='docker run \
    --network host \
    --cap-add=ALL \
    --privileged=false \
    --name rinx-devenv \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.dotfiles:/root/.dotfiles \
    -v $HOME/.ssh:/root/.ssh \
    -v $HOME/.gitconfig.local:/root/.gitconfig.local \
    -v $HOME/local:/root/local \
    -v $HOME/tmp:/root/tmp \
    -v $HOME/works:/root/works \
    -v $HOME/Downloads:/root/Downloads \
    -dit rinx/devenv'
alias devattach='docker exec -it rinx-devenv /bin/zsh'
alias devstop='docker stop rinx-devenv && docker rm rinx-devenv'

