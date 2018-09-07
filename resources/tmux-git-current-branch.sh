#!/bin/zsh

if git_status=$(cd $1 && git status 2>/dev/null ); then
    git_branch="$(echo $git_status| awk 'NR==1 {print $3}')"
    case $git_status in
        *Changes\ not\ staged* ) state="#[bg=black,fg=magenta] + #[fg=default]" ;;
        *Changes\ to\ be\ committed* ) state="#[bg=black,fg=blue] + #[default]" ;; 
        * ) state="#[bg=black,fg=green] ✔ #[default]" ;;
    esac
    git_info="#[underscore]#[bg=black,fg=blue][${git_branch}]#[default]${state}"
else
    git_info=""
fi

directory="#[underscore]#[bg=black,fg=cyan][$1]#[default]"

echo "$directory $git_info"
