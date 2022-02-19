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
