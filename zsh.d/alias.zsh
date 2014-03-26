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
alias pandoclt='pandoc -V documentclass=ltjarticle --latex-engine=lualatex'

#hub aliasing (https://github.com/defunkt/hub)
function git() {hub "$@"}

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


