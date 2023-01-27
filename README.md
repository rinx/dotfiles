# dotfiles

[![release](https://img.shields.io/github/v/release/rinx/dotfiles?style=flat-square)](https://github.com/rinx/dotfiles/releases)
[![DockerHub](https://img.shields.io/docker/pulls/rinx/devenv?label=rinx%2Fdevenv&logo=docker&style=flat-square)](https://hub.docker.com/r/rinx/devenv)
[![ghcr.io](https://img.shields.io/badge/ghcr.io-rinx%2Fdevenv-brightgreen?logo=docker&style=flat-square)](https://github.com/users/rinx/packages/container/package/devenv)
[![benchmark](https://img.shields.io/badge/benchmark-nvim%2Fzsh-brightgreen?style=flat-square)](https://rinx.github.io/dotfiles/dev/bench/)

Pull the latest stable image `ghcr.io/rinx/devenv:stable`, that is built from [the latest release](https://github.com/rinx/dotfiles/releases).
(or `ghcr.io/rinx/devenv:nightly` = the image built from the latest main branch is also available.
[please see here](https://github.com/users/rinx/packages/container/package/devenv))

## Usage


### Deploy

To deploy assets in the home directory, put this repository into `~/.dotfiles` and run `make deploy`.

```sh
git clone https://github.com/rinx/dotfiles.git ~/.dotfiles
```

```sh
cd ~/.dotfiles
make deploy
```

### Devcontainer

To run dev container, 

```sh
docker run \
    --name devenv \
    --restart always \
    -v $HOME/local:/root/local \
    -v $HOME/works:/root/works \
    -p 16666:16666 \
    -dit ghcr.io/rinx/devenv:stable
```

After that, attach your Neovim frontend to 16666 port.

e.g.) [Neovide](https://github.com/neovide/neovide)

```sh
neovide --remote-tcp localhost:16666
```

It works like [VSCode Remote Container](https://code.visualstudio.com/docs/remote/containers) extension.

<div align="center">
<a href="https://user-images.githubusercontent.com/1588935/141971200-aa5ad698-78c0-4ea2-8b2b-73840777fea7.png">
<img src="https://user-images.githubusercontent.com/1588935/141971200-aa5ad698-78c0-4ea2-8b2b-73840777fea7.png" width="100%">
</a>
</div>

After finished your work, stop and remove the container.

```sh
docker stop devenv
docker rm devenv
```
