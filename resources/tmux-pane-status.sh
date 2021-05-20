#!/bin/zsh

if k8s_context="$(kubectl config current-context 2>/dev/null)"; then
    # k8s_user="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$k8s_context\")].context.user}")"
    k8s_ns="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$k8s_context\")].context.namespace}")"
    [[ -z "$k8s_ns" ]] && k8s_ns="default"
    k8s_info="#[underscore]#[bg=default,fg=yellow][ﴱ ${k8s_context}/${k8s_ns}]#[default]"
else
    k8s_info=""
fi

directory="#[underscore]#[bg=default,fg=cyan][ $1]#[default]"

echo "$directory $k8s_info"
