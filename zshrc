OS=$(uname -s)

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

    zinit ice pick"async.zsh" src"pure.zsh"
    zinit light sindresorhus/pure

    zinit light zsh-users/zsh-autosuggestions
    zinit light zdharma/fast-syntax-highlighting
    zinit light hlissner/zsh-autopair

    zinit ice from"gh" as"program" \
            make"install" \
            pick"bin/(fzf|fzf-tmux)"
    zinit light junegunn/fzf

    zinit wait lucid for Aloxaf/fzf-tab

    zinit ice from"gh-r" as"program" mv"exa* -> exa" pick"exa"
    zinit light ogham/exa

    zinit ice from"gh-r" as"program" mv"ripgrep* -> rg" pick"rg/rg"
    zinit light BurntSushi/ripgrep

    zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat"
    zinit light sharkdp/bat

    zinit ice from"gh-r" as"program" mv"fd* -> fd" pick"fd/fd"
    zinit light sharkdp/fd

    zinit ice from"gh-r" as"program" pick"bb"
    zinit light borkdude/babashka

    zinit ice from"gh-r" as"program" pick"clj-kondo"
    zinit light borkdude/clj-kondo

    zinit ice from"gh-r" as"program" mv"ghq* -> ghq" pick"ghq/ghq"
    zinit light x-motemen/ghq

    zinit ice from"gh-r" as"program" mv"jq-* -> jq" pick"jq"
    zinit light stedolan/jq

    zinit ice from"gh-r" as"program" mv"stern* -> stern" pick"stern/stern"
    zinit light stern/stern

    zinit ice from"gh-r" as"program" pick"k9s"
    zinit light derailed/k9s

    zinit ice from"gh-r" as"program" mv"helmfile* -> helmfile" pick"helmfile"
    zinit light roboll/helmfile

    zinit ice from"gh-r" as"program" pick"kustomize"
    zinit light kubernetes-sigs/kustomize

    zinit ice from"gh" as"program" pick"(kubectx|kubens)"
    zinit light ahmetb/kubectx

    zinit ice from"gh" as"program" \
            atclone"./autogen.sh; ./configure" \
            make \
            pick"tmux"
    zinit light tmux/tmux

    zinit ice from"gh" as"program" pick"bin/xpanes"
    zinit light greymd/tmux-xpanes

    # zinit ice from"gh" as"program" \
    #         make"CMAKE_BUILD_TYPE=RelWithDebInfo" \
    #         pick"build/bin/nvim"
    # zinit light neovim/neovim

    zinit wait lucid atload"zicompinit; zicdreplay" blockf for zsh-users/zsh-completions

    zinit light-mode lucid wait has"kubectl" for \
            id-as"kubectl_completion" \
            as"completion" \
            atclone"kubectl completion zsh > _kubectl" \
            atpull"%atclone" \
            run-atpull \
            zdharma/null
fi

autoload -Uz compinit
compinit

zinit cdreplay -q

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
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':prompt:pure:git:stash' show yes

autoload colors
colors

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

bindkey '^R' history-incremental-search-backward
bindkey '^E' history-incremental-search-forward

edit_current_line() {
    local tmpfile=$(mktemp)
    echo "$BUFFER" > $tmpfile
    nvim $tmpfile -c "normal $" -c "set filetype=zsh"
    BUFFER="$(cat $tmpfile)"
    CURSOR=${#BUFFER}
    rm $tmpfile
    zle reset-prompt
}
zle -N edit_current_line
bindkey '^O' edit_current_line

setopt list_packed
setopt nolistbeep

setopt auto_cd
setopt auto_pushd

setopt auto_list
setopt auto_menu

setopt auto_param_slash
setopt auto_param_keys

setopt correct

function precmd() {
    if [ ! -z $TMUX ]; then
        tmux refresh-client -S
    fi
}

if [ -n "${DOCKERIZED_DEVENV}" ]; then
    PURE_PROMPT_SYMBOL="${DOCKERIZED_DEVENV} ❯"
    PURE_PROMPT_VICMD_SYMBOL="${DOCKERIZED_DEVENV} ❮"
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


if builtin command -v exa > /dev/null 2>&1 ; then
    alias ls='exa'
    alias lsa='exa -a'
    alias lsl='exa -l'
    alias lsal='exa -a -l'
else
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
            alias fzf='fzf-tmux -p'
        fi
    fi

    fzf-search-history() {
      BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
      CURSOR=${#BUFFER}
    }
    zle -N fzf-search-history
    bindkey '^F' fzf-search-history

    fzf-git-hash() {
        hash=$(git -c color.ui=always log --pretty=format:'%C(yellow)%h%Creset %s %C(white)- %an, %ar%Creset'| fzf --ansi +m | awk '{print $1}')
        LBUFFER="${LBUFFER}${hash}"
    }
    zle -N fzf-git-hash
    bindkey '^H' fzf-git-hash

    if builtin command -v fd > /dev/null 2>&1 ; then
        fzf-select-file() {
            dir=$(fd 2> /dev/null | fzf +m)
            LBUFFER="${LBUFFER}${dir}"
        }
        zle -N fzf-select-file
        bindkey '^K' fzf-select-file
    fi

    fgbr() {
        local branches branch
        branches=$(git branch --all | grep -v HEAD)
        branch=$(echo "$branches" | fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m | sed "s/.* //" | sed "s#remotes/[^/]*/##")
        print -z "git checkout $branch"
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
