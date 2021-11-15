# dotfiles

[![release](https://img.shields.io/github/v/release/rinx/dotfiles?style=flat-square)](https://github.com/rinx/dotfiles/releases)
[![DockerHub](https://img.shields.io/docker/pulls/rinx/devenv?label=rinx%2Fdevenv&logo=docker&style=flat-square)](https://hub.docker.com/r/rinx/devenv)
[![ghcr.io](https://img.shields.io/badge/ghcr.io-rinx%2Fdevenv-brightgreen?logo=docker&style=flat-square)](https://github.com/users/rinx/packages/container/package/devenv)

Pull the latest stable image `ghcr.io/rinx/devenv:stable`, that is built from [the latest release](https://github.com/rinx/dotfiles/releases).
(or `ghcr.io/rinx/devenv:nightly` = the image built from the latest main branch is also available.
[please see here](https://github.com/users/rinx/packages/container/package/devenv))

## Usage

Start container.

```sh
docker run \
    --name devenv \
    --restart always \
    -v $HOME/local:/root/local \
    -v $HOME/works:/root/works \
    -p 16666:16666 \
    -dit ghcr.io/rinx/devenv:stable
```

Attach your Neovim frontend to 16666 port.
e.g. Neovide

```sh
neovide --remote-tcp localhost:16666
```

After finished your work, stop and remove the container.

```sh
docker stop devenv
docker rm devenv
```
