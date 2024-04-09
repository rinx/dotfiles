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

if builtin command -v eza > /dev/null 2>&1 ; then
    alias ls='eza'
    alias lsa='eza -a'
    alias lsl='eza -l'
    alias lsal='eza -a -l'
elif builtin command -v exa > /dev/null 2>&1 ; then
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

alias q='exit'

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

    ghco() {
        id="$(gh pr list | fzf | cut -f1)"
        [ -n "$id" ] && gh pr checkout "$id"
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

if builtin command -v kubecolor > /dev/null 2>&1 ; then
    alias k=kubecolor
fi
