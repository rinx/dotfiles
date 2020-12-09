OS=$(uname -s)

autoload -U compinit
compinit

# completion settings
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

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
    if [ ${#DOCKERIZED_DEVENV} -gt 12 ]; then
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

# zinit
export ZINIT_HOME=$HOME/.zinit

if builtin command -v git > /dev/null 2>&1 ; then
    if [ ! -f ${ZINIT_HOME}/bin/zinit.zsh ];  then
        mkdir -p ${ZINIT_HOME}
        git clone --depth=1 https://github.com/zdharma/zinit.git ${ZINIT_HOME}/bin
    fi

    source ${ZINIT_HOME}/bin/zinit.zsh

    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    zinit light zsh-users/zsh-autosuggestions
    zinit light zdharma/fast-syntax-highlighting

    zinit light Aloxaf/fzf-tab

    zinit pack for fzf

    zinit ice from"gh-r" as"program" mv"exa* -> ls"
    zinit light ogham/exa

    zinit ice from"gh-r" as"program" mv"rg* -> rg" pick"rg/rg"
    zinit light BurntSushi/ripgrep

    zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat"
    zinit light sharkdp/bat

    zinit ice from"gh-r" as"program" mv"fd* -> fd" pick"fd/fd"
    zinit light sharkdp/fd

    zinit ice from"gh-r" as"program" mv"babashka-* -> bb"
    zinit load borkdude/babashka

    zinit ice from"gh-r" as"program" mv"*/ghq -> ghq"
    zinit load x-motemen/ghq

    zinit ice from"gh-r" as"program" mv"jq-* -> jq"
    zinit load stedolan/jq

    zinit ice from"gh" as"program" pick"bin/xpanes"
    zinit load greymd/tmux-xpanes

    zinit wait lucid atload"zicompinit; zicdreplay" blockf for zsh-users/zsh-completions
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

alias vi='nvim'
alias lvim='nvim'

alias q='exit'

# grep
if builtin command -v grep > /dev/null 2>&1 ; then
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
fi

if builtin command -v rg > /dev/null 2>&1 ; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git" --no-ignore'
fi

if builtin command -v bat > /dev/null 2>&1 ; then
    alias bat='bat --paging=never'
    alias batp='bat --paging=auto'
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
        branches=$(git branch --all | grep -v HEAD)
        branch=$(echo "$branches" | fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m | sed "s/.* //" | sed "s#remotes/[^/]*/##")
        print -z "git checkout $branch"
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
            dir=$(ghq list --vcs git | fzf +m)
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

    fgitmoji-cache() {
        curl -o ~/.gitmojis.json --silent 'https://raw.githubusercontent.com/carloscuesta/gitmoji/master/src/data/gitmojis.json'
    }

    fgitmoji() {
        if [ ! -f ~/.gitmojis.json ]; then
            fgitmoji-cache
        fi
        target=$(cat ~/.gitmojis.json | jq -r '.gitmojis[] | "\(.emoji) \(.code) \(.description)"' | fzf -m | awk '{print $2}')
        if [[ "$target" != "" ]]; then
            print -z "git commit --signoff -m \"$target \""
        fi
    }

    fgitmoji-prefix() {
        if [ ! -f ~/.gitmojis.json ]; then
            fgitmoji-cache
        fi
        semver=$(echo "[ci skip]\n[patch]\n[minor]\n[major]" | fzf -m)
        target=$(cat ~/.gitmojis.json | jq -r '.gitmojis[] | "\(.emoji) \(.code) \(.description)"' | fzf -m | awk '{print $2}')
        if [[ "$target" != "" ]]; then
            print -z "git commit --signoff -m \"$semver $target \""
        fi
    }

    tinysnip-base() {
        namespaces=$1
        filters=`echo $2 | jet --query '(str #jet/lit "(filter [:tags (get " (id) #jet/lit ")])")' | jet --collect --to json | jq -r '.[]' | tr '\n' ' '`
        cat ~/.dotfiles/resources/tinysnip.edn | \
            jet --query "[$namespaces $filters (map (str #jet/lit \"[[\" :title #jet/lit \"]] \" :body))]" --to json | \
            jq -r '.[]' | \
            fzf -m | \
            sed -e 's/^\[\[.*\]\] //g'
    }

    tinysnip-gh-badge() {
        tinysnip-base ':user :snippets' ':github :badge'
    }

    tinysnip-kaomoji() {
        tinysnip-base ':user :snippets' ':kaomoji'
    }

    tinysnip() {
        print -z $(echo "tinysnip-gh-badge\ntinysnip-kaomoji" | fzf -m)
    }
fi

# xsel (linux only)
if builtin command -v xsel > /dev/null 2>&1 ; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

# git aliases
alias gst='git status -s -b'

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

# clojure
# (please refer `deps.edn`)
if builtin command -v rlwrap > /dev/null 2>&1 ; then
    alias cljdev='clj -A:dev -r'
    alias bbrepl='rlwrap bb --repl'
else
    alias cljdev='clojure -A:dev -r'
    alias bbrepl='bb --repl'
fi

# kube
if builtin command -v kubectl > /dev/null 2>&1 ; then
    source <(kubectl completion zsh)
fi

# docker
container_name='rinx-devenv'

devstarter() {
    image_name=$1
    shift
    opts="\
        --cap-add=ALL \
        --privileged=false \
        --name $container_name \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v $HOME/.dotfiles:/root/.dotfiles:delegated \
        -v $HOME/.gitconfig.local:/root/.gitconfig.local:ro \
        -v $HOME/.git-credentials:/root/.git-credentials:ro \
        -v $HOME/.kube:/root/.kube \
        -v $HOME/tmp:/root/tmp \
        -v $HOME/works:/root/works \
        -v $HOME/Downloads:/root/Downloads \
        -v $HOME/.zsh_history:/root/.zsh_history \
        -v $HOME/.skk-jisyo:/root/.skk-jisyo \
        $@"

    case "$(uname -s)" in
        Darwin)
            opts="$opts -v $HOME/.ssh:/root/.ssh:ro"
            ;;
        Linux)
            opts="$opts -v $HOME/local/src:/root/local/src:delegated"
            opts="--net=host $opts"
            if [[ -n "${SSH_AUTH_SOCK}" ]]; then
                opts="$opts -v ${SSH_AUTH_SOCK}:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent"
            fi
            ;;
        *)
            ;;
        esac

    start_cmd="docker run $opts -dit $image_name"
    echo $start_cmd | sed -e 's/ \+/ /g'
    eval $start_cmd
}

devstart-stable() {
    devstarter ghcr.io/rinx/devenv:stable $@
}

devstart() {
    devstarter ghcr.io/rinx/devenv:nightly $@
}

alias devattach="docker exec -it $container_name /bin/zsh"
alias devstop="docker stop $container_name && docker rm $container_name"

if [ ! -f "$HOME/.zshrc.zwc" -o "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc" ]; then
    zcompile $HOME/.zshrc
fi

if [ ! -f "$HOME/.zcompdump.zwc" -o "$HOME/.zcompdump" -nt "$HOME/.zcompdump.zwc" ]; then
    zcompile $HOME/.zcompdump
fi
