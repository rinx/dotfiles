# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L44
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zlogin#L9-L15
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
# https://htr3n.github.io/2018/07/faster-zsh/
function run-compinit() {
    # run compinit in a smarter, faster way
    emulate -L zsh
    setopt localoptions extendedglob

    ZSH_COMPDUMP=${ZSH_COMPDUMP:-$XDG_CACHE_HOME/zsh/zcompdump}
    [[ -d "$ZSH_COMPDUMP:h" ]] || mkdir -p "$ZSH_COMPDUMP:h"
    autoload -Uz compinit

    # if compdump is less than 20 hours old,
    # consider it fresh and shortcut it with `compinit -C`
    #
    # Glob magic explained:
    #   #q expands globs in conditional expressions
    #   N - sets null_glob option (no error on 0 results)
    #   mh-20 - modified less than 20 hours ago
    if [[ "$1" != "-f" ]] && [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
        # -C (skip function check) implies -i (skip security check).
        compinit -C -d "$ZSH_COMPDUMP"
    else
        compinit -i -d "$ZSH_COMPDUMP"
        touch "$ZSH_COMPDUMP"
    fi

    # Compile zcompdump, if modified, in background to increase startup speed.
    {
        if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
            zcompile "$ZSH_COMPDUMP"
        fi
    } &!
}
if ! zstyle -t ':zshzoo:plugin:compinit' defer; then
    run-compinit
fi

if builtin command -v kubectl > /dev/null 2>&1 ; then
    source <(kubectl completion zsh)
fi

if builtin command -v kubecolor > /dev/null 2>&1 ; then
    compdef kubecolor=kubectl
fi

if builtin command -v kustomize > /dev/null 2>&1 ; then
    source <(kustomize completion zsh)
fi

if builtin command -v deno > /dev/null 2>&1 ; then
    source <(deno completions zsh)
fi

if builtin command -v gh > /dev/null 2>&1 ; then
    source <(gh completion -s zsh)
fi

if builtin command -v helm > /dev/null 2>&1 ; then
    source <(helm completion zsh)
fi

if builtin command -v helmfile > /dev/null 2>&1 ; then
    source <(helmfile completion zsh)
fi

if builtin command -v buf > /dev/null 2>&1 ; then
    source <(buf completion zsh)
fi

if builtin command -v tenv > /dev/null 2>&1 ; then
    source <(tenv completion zsh)
fi

if builtin command -v sg > /dev/null 2>&1 ; then
    source <(sg completions zsh)
fi
