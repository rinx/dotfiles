OS=$(uname -s)
export GPG_TTY=$TTY

# zinit
export ZINIT_HOME=$HOME/.zinit

if builtin command -v git > /dev/null 2>&1 ; then
    if [ ! -f ${ZINIT_HOME}/bin/zinit.zsh ]; then
        mkdir -p ${ZINIT_HOME}
        git clone --depth=1 https://github.com/zdharma/zinit.git ${ZINIT_HOME}/bin
    fi

    source ${ZINIT_HOME}/bin/zinit.zsh

    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    zinit ice pick"async.zsh" src"pure.zsh"
    zinit light sindresorhus/pure

    zinit ice from"gh" as"program" \
            make"install" \
            atclone"cp shell/completion.zsh _fzf" \
            atpull"%atclone" \
            pick"bin/(fzf|fzf-tmux)"
    zinit light junegunn/fzf

    zinit ice wait
    zinit light zsh-users/zsh-autosuggestions

    zinit ice wait
    zinit light zdharma/fast-syntax-highlighting

    zinit ice wait
    zinit light hlissner/zsh-autopair

    zinit ice wait
    zinit light Aloxaf/fzf-tab

    zinit ice from"gh-r" as"program" pick"bin/exa"
    zinit light ogham/exa

    zinit ice wait from"gh-r" \
            as"program" \
            mv"ripgrep* -> rg" \
            pick"rg/rg" \
            nocompletions
    zinit light BurntSushi/ripgrep

    zinit ice wait from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat"
    zinit light sharkdp/bat

    zinit ice wait from"gh-r" \
            as"program" \
            mv"fd* -> fd" \
            pick"fd/fd" \
            nocompletions
    zinit light sharkdp/fd

    zinit ice wait"2" lucid from"gh-r" as"program" pick"sad"
    zinit light ms-jpq/sad

    zinit ice wait"2" from"gh-r" as"program" mv"delta* -> delta" pick"delta/delta"
    zinit light dandavison/delta

    zinit ice from"gh-r" as"program" mv"ghq* -> ghq" pick"ghq/ghq"
    zinit light x-motemen/ghq

    zinit ice wait"4" lucid from"gh-r" as"program" pick"bb"
    zinit light babashka/babashka

    zinit ice wait"4" lucid from"gh-r" as"program" pick"clj-kondo"
    zinit light clj-kondo/clj-kondo

    zinit ice wait"1" lucid from"gh-r" as"program" mv"jq-* -> jq" pick"jq"
    zinit light stedolan/jq

    zinit ice wait"4" lucid from"gh-r" as"program" mv"yq* -> yq" pick"yq"
    zinit light mikefarah/yq

    zinit ice wait"3" lucid from"gh-r" as"program" mv"stern* -> stern" pick"stern/stern"
    zinit light stern/stern

    zinit ice wait"1" lucid from"gh-r" as"program" pick"k9s"
    zinit light derailed/k9s

    zinit ice wait"3" lucid from"gh-r" as"program" mv"helmfile* -> helmfile" pick"helmfile"
    zinit light roboll/helmfile

    zinit ice wait"3" lucid from"gh-r" as"program" pick"kustomize"
    zinit light kubernetes-sigs/kustomize

    zinit ice wait"3" lucid from"gh" as"program" pick"(kubectx|kubens)"
    zinit light ahmetb/kubectx

    zinit ice wait"3" lucid from"gh-r" as"program" mv"kubefwd -> kubectl-kubefwd" pick"kubectl-kubefwd"
    zinit light txn2/kubefwd

    zinit ice from"gh" as"program" \
            atclone"./autogen.sh; ./configure" \
            atpull"%atclone" \
            make \
            pick"tmux"
    zinit light tmux/tmux

    zinit ice wait"1" lucid from"gh" as"program" pick"bin/xpanes"
    zinit light greymd/tmux-xpanes

    zinit wait atload"zicompinit; zicdreplay" blockf for zsh-users/zsh-completions

    zinit light-mode lucid wait has"kubectl" for \
            id-as"kubectl_completion" \
            as"completion" \
            atclone"kubectl completion zsh > _kubectl" \
            atpull"%atclone" \
            run-atpull \
            zdharma/null

    zinit light-mode lucid wait has"helm" for \
            id-as"helm_completion" \
            as"completion" \
            atclone"helm completion zsh > _helm" \
            atpull"%atclone" \
            run-atpull \
            zdharma/null

    zinit light-mode lucid wait has"helmfile" for \
            id-as"helmfile_completion" \
            as"completion" \
            atclone"curl -s https://raw.githubusercontent.com/roboll/helmfile/master/autocomplete/helmfile_zsh_autocomplete > _helmfile" \
            atpull"%atclone" \
            run-atpull \
            zdharma/null

    zinit light-mode lucid wait has"kustomize" for \
            id-as"kustomize_completion" \
            as"completion" \
            atclone"kustomize completion zsh > _kustomize" \
            atpull"%atclone" \
            run-atpull \
            zdharma/null

    zinit ice wait"1" lucid from"git.zx2c4.com" as"program" \
            atclone"cp src/completion/pass.zsh-completion _pass_completion" \
            atpull"%atclone" \
            make"PREFIX=$ZPFX install" \
            pick"$ZPFX/bin/pass"
    zinit light password-store

    zinit ice wait"2" lucid from"gh-r" as"program" \
            bpick"*pass*" \
            pick"docker-credential-pass"
    zinit light docker/docker-credential-helpers

    case "$OS" in
        Darwin)
            zinit ice wait"1" from"gh-r" ver"nightly" as"program" \
                    mv"nvim-* -> nvim" \
                    bpick"*macos*" \
                    pick"nvim/bin/nvim"
            ;;
        *)
            zinit ice wait"1" from"gh-r" ver"nightly" as"program" \
                    mv"nvim-* -> nvim" \
                    bpick"*linux*" \
                    pick"nvim/bin/nvim"
            ;;
        esac
    zinit light neovim/neovim
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
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 5
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

if [ -n "${NVIM_LISTEN_ADDRESS}" ]; then
    export EDITOR='nvr'
    export GIT_EDITOR="$EDITOR -cc split --remote-wait"
else
    export EDITOR='nvim'
    export GIT_EDITOR="$EDITOR"
fi

export VISUAL="$EDITOR"

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
    export FZF_DEFAULT_OPTS="--ansi --select-1 --exit-0 --reverse --cycle"
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
    bindkey '^G' fzf-git-hash

    if builtin command -v fd > /dev/null 2>&1 ; then
        fzf-select-file() {
            dir=$(fd 2> /dev/null | fzf +m)
            LBUFFER="${LBUFFER}${dir}"
        }
        zle -N fzf-select-file
        bindkey '^K' fzf-select-file
    fi

    gbr() {
        branch=$(git branch --sort=-committerdate --all | fzf +m | tr -d '[:space:]')
        if [[ "$branch" != "" ]]; then
            git checkout $branch
        fi
    }

    if builtin command -v ghq > /dev/null 2>&1 ; then
        ghq-list() {
            local groot
            groot=$(ghq root)
            fd --exact-depth 3 -t d . $groot | sed -e "s#$groot/##g"
        }

        gq() {
            local dir
            dir=$(ghq-list | fzf +m)
            if [[ "$dir" != "" ]]; then
                cd "`ghq root`/$dir"
            fi
        }
    fi

    devmoji() {
        target=$(cat ~/.devmojis | fzf -m | awk '{print $1,$3}')
        if [[ "$target" != "" ]]; then
            print -z "git commit --signoff -m \"$target \""
        fi
    }
fi

# xsel (linux only)
if builtin command -v xsel > /dev/null 2>&1 ; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

# git aliases
alias gs='git status'
alias gl='git l'

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
        -v $HOME/.config/gh:/root/.config/gh \
        -v $HOME/.kube:/root/.kube \
        -v $HOME/.gnupg:/root/.gnupg \
        -v $HOME/.password-store:/root/.password-store \
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
