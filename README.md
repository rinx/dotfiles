# dotfiles

[![release](https://img.shields.io/github/v/release/rinx/dotfiles?style=flat-square)](https://github.com/rinx/dotfiles/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/rinx/devenv.svg?style=flat-square)](https://hub.docker.com/r/rinx/devenv)
[![GitHub Actions: Run gitwerk](https://github.com/rinx/dotfiles/workflows/Run%20gitwerk/badge.svg)](https://github.com/rinx/dotfiles/actions)
[![GitHub Actions: Build docker image](https://github.com/rinx/dotfiles/workflows/Build%20docker%20image/badge.svg)](https://github.com/rinx/dotfiles/actions)

Pull the latest stable image `rinx/devenv:stable`, that is built from [the latest release](https://github.com/rinx/dotfiles/releases).
(or `rinx/devenv:nightly` = the image built from the latest master branch is also available.
[please see here](https://hub.docker.com/r/rinx/devenv/tags))

    $ docker pull rinx/devenv:stable

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
    -dit rinx/devenv:stable'
alias devattach='docker exec -it rinx-devenv /bin/zsh'
alias devstop='docker stop rinx-devenv && docker rm rinx-devenv'
```

Start your `devenv`.

    $ devstart

And attach to it.

    $ devattach

After finished your work, stop the environment.

    $ devstop

