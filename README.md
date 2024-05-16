# dotfiles

[![build](https://img.shields.io/github/actions/workflow/status/rinx/dotfiles/nix.yml?style=flat-square&label=nix%20build&logo=nixos)](https://github.com/rinx/dotfiles/actions/workflows/nix.yml)
[![benchmark](https://img.shields.io/github/actions/workflow/status/rinx/dotfiles/benchmark.yaml?style=flat-square&logo=neovim&label=benchmark%20for%20zsh%2Fneovim
)](https://rinx.github.io/dotfiles/dev/bench/)

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

### Nix shell

```sh
nix develop --command zsh
```
