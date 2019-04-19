# dotfiles
[![CircleCI](https://circleci.com/gh/rinx/dotfiles/tree/master.svg?style=svg)](https://circleci.com/gh/rinx/dotfiles/tree/master)
[![Docker Pulls](https://img.shields.io/docker/pulls/rinx/devenv.svg?style=flat-square)](https://hub.docker.com/r/rinx/devenv)

## Use Dockerized environment

Pull the latest image.

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


## Use standard environment

### setup

Use `make`

## install and uninstall

### install

clone this repository and run `make`

    $ git clone https://github.com/rinx/dotfiles.git ~/.dotfiles
    $ make deploy && make init

#### future works

test deploy & init phase,

    $ make test

check installed objects,

    $ make check-commands

for uninstall,

    $ make clean

add install phase of dependencies belows by

    $ make install-dependencies
