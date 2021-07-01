# dotfiles

[![release](https://img.shields.io/github/v/release/rinx/dotfiles?style=flat-square)](https://github.com/rinx/dotfiles/releases)
[![DockerHub](https://img.shields.io/docker/pulls/rinx/devenv?label=rinx%2Fdevenv&logo=docker&style=flat-square)](https://hub.docker.com/r/rinx/devenv)
[![ghcr.io](https://img.shields.io/badge/ghcr.io-rinx%2Fdevenv-brightgreen?logo=docker&style=flat-square)](https://github.com/users/rinx/packages/container/package/devenv)

Pull the latest stable image `ghcr.io/rinx/devenv:stable`, that is built from [the latest release](https://github.com/rinx/dotfiles/releases).
(or `ghcr.io/rinx/devenv:nightly` = the image built from the latest main branch is also available.
[please see here](https://github.com/users/rinx/packages/container/package/devenv))

    $ docker pull ghcr.io/rinx/devenv:stable

Add aliases to your shell (they're already described in `zshrc` in this repository).

```sh
# docker
alias devstart='docker run \
    --network host \
    --cap-add=ALL \
    --privileged=false \
    --name rinx-devenv \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/root/.ssh \
    -v $HOME/.gitconfig.local:/root/.gitconfig.local \
    -v $HOME/local:/root/local \
    -v $HOME/works:/root/works \
    -v $HOME/Downloads:/root/Downloads \
    -dit ghcr.io/rinx/devenv:stable'
alias devattach='docker exec -it rinx-devenv /bin/zsh'
alias devstop='docker stop rinx-devenv && docker rm rinx-devenv'
```

Start your `devenv`.

    $ devstart

And attach to it.

    $ devattach

After finished your work, stop the environment.

    $ devstop
