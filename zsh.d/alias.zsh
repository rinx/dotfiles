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

alias ls='ls --color -F'
alias lsa='ls --color -F -a'
alias lsl='ls --color -F -l'
alias lsal='ls --color -F -a -l'

#start vim as vi
alias vi='vim'

#tmux execute as 256colors-terminal
alias tmux='tmux -2'

alias be='bundle exec'

alias q='exit'

#grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#global
alias -g @l='| less'
alias -g @h='| head'
alias -g @t='| tail'
alias -g @g='| grep'

#pandoc with lualatex
if builtin command -v pandoc > /dev/null 2>&1 ; then
    alias pandoclt='pandoc -V documentclass=ltjarticle --latex-engine=lualatex'
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

alias gtl='git l'

