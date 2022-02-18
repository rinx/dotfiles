# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

OS=$(uname -s)
export GPG_TTY=$TTY
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

HISTFILE=~/.dotfiles.local/zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

export PATH=$PATH:~/.bin

## https://github.com/mattmc3/zsh_unplugged
## clone a plugin, identify its init file, source it, and add it to your fpath
function plugin-load() {
  local repo plugin_name plugin_dir initfile initfiles
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  for repo in $@; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh
    if [[ ! -d $plugin_dir ]]; then
      echo "Cloning $repo"
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugin_dir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

function plugin-compile() {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  autoload -U zrecompile
  local f
  for f in $ZPLUGINDIR/**/*.zsh{,-theme}(N); do
    zrecompile -pq "$f"
  done
}


plugins=(
    romkatv/powerlevel10k
    romkatv/zsh-defer

    zshzoo/history
    zshzoo/zstyle-completions
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    hlissner/zsh-autopair
    mollifier/cd-gitroot

    zshzoo/compinit
    zdharma-continuum/fast-syntax-highlighting
)

plugin-load $plugins

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

setopt always_to_end
setopt auto_list
setopt auto_menu
setopt auto_param_slash
setopt complete_in_word
setopt no_menu_complete

setopt extended_glob
setopt glob_dots

setopt no_clobber
setopt no_correct
setopt no_correct_all
setopt no_flow_control
setopt interactive_comments
setopt no_mail_warning
setopt path_dirs
setopt rc_quotes
setopt no_rm_star_silent

setopt auto_resume
setopt no_bg_nice
setopt no_check_jobs
setopt no_hup
setopt long_list_jobs
setopt notify

setopt prompt_subst

setopt no_beep
setopt combining_chars
setopt vi

autoload colors
colors

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

function precmd() {
    if [ ! -z $TMUX ]; then
        tmux refresh-client -S
    fi
}

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -n "${DOCKERIZED_DEVENV}" ]; then
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION="${DOCKERIZED_DEVENV} ❯"
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION="${DOCKERIZED_DEVENV} ❮"
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION="${DOCKERIZED_DEVENV} ❮"
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
alias cdg='cd-gitroot'

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
alias nvui='nvui --ext_multigrid --detached'

if [ -n "${NVIM_LISTEN_ADDRESS}" ]; then
    export EDITOR='nvr'
    export GIT_EDITOR="$EDITOR -cc vsplit --remote-wait"
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
    if [ ! -z $TMUX ] && [ -z $VIMRUNTIME ]; then
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

if builtin command -v fzy > /dev/null 2>&1 ; then
    if builtin command -v fzy-tmux > /dev/null 2>&1 ; then
        alias fzy=fzy-tmux
    fi
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

# kitty aliases
alias icat='kitty +kitten icat'
alias vdiff="kitty +kitten diff"

# docker
container_name='rinx-devenv'

devstarter() {
    image_name=$1
    shift
    opts="\
        --name $container_name \
        --restart always \
        -v $HOME/.dotfiles:/root/.dotfiles:delegated \
        -v $HOME/.dotfiles.local:/root/.dotfiles.local:ro \
        -v $HOME/.config/gh:/root/.config/gh \
        -v $HOME/.kube:/root/.kube \
        -v $HOME/.gnupg:/root/.gnupg \
        -v $HOME/.password-store:/root/.password-store \
        -v $HOME/tmp:/root/tmp \
        -v $HOME/works:/root/works \
        -v $HOME/local/src:/root/local/src:delegated \
        $@"

    case "$(uname -s)" in
        Darwin)
            opts="$opts -v $HOME/.ssh:/root/.ssh:ro"
            opts="-v $HOME/Library/Fonts:/root/.fonts:ro $opts"
            opts="-p 16666:16666 $opts"
            ;;
        Linux)
            opts="--net=host $opts"
            opts="-e DISPLAY=$DISPLAY $opts"
            opts="-v /tmp/.X11-unix:/tmp/.X11-unix $opts"
            opts="-v $HOME/.fonts:/root/.fonts:ro $opts"
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

alias devnvim='neovide --multigrid --remote-tcp localhost:16666'
alias devattach="docker exec -it $container_name /bin/zsh"
alias devstop="docker stop $container_name && docker rm $container_name"

if [ ! -f "$HOME/.zshrc.zwc" -o "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc" ]; then
    zcompile $HOME/.zshrc
fi

if [ ! -f "$HOME/.zcompdump.zwc" -o "$HOME/.zcompdump" -nt "$HOME/.zcompdump.zwc" ]; then
    zcompile $HOME/.zcompdump
fi
