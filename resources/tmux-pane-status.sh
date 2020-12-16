#!/bin/zsh

# if git_status=$(cd $1 && git status 2>/dev/null ); then
#     git_branch="$(echo $git_status| awk 'NR==1 {print $3}')"
#     case $git_status in
#         *Changes\ not\ staged* ) state="#[bg=black,fg=magenta]  #[fg=default]" ;;
#         *Changes\ to\ be\ committed* ) state="#[bg=black,fg=blue]  #[default]" ;;
#         * ) state="#[bg=black,fg=green]  #[default]" ;;
#     esac
#     git_info="#[underscore]#[bg=black,fg=blue][ ${git_branch}]#[default]${state}"
# else
#     git_info=""
# fi

if k8s_context="$(kubectl config current-context 2>/dev/null)"; then
    # k8s_user="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$k8s_context\")].context.user}")"
    k8s_ns="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$k8s_context\")].context.namespace}")"
    [[ -z "$k8s_ns" ]] && k8s_ns="default"
    k8s_info="#[underscore]#[bg=black,fg=yellow][ ${k8s_context}/${k8s_ns}]#[default]"
else
    k8s_info=""
fi

directory="#[underscore]#[bg=black,fg=cyan][ $1]#[default]"

echo "$directory $k8s_info"
