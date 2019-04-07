# dotfiles
[![CircleCI](https://circleci.com/gh/rinx/dotfiles/tree/master.svg?style=svg)](https://circleci.com/gh/rinx/dotfiles/tree/master)
[![Docker Pulls](https://img.shields.io/docker/pulls/rinx/devenv.svg?style=flat-square)](https://hub.docker.com/r/rinx/devenv)

## Use Dockerized environment

Pull the latest image.

    $ docker pull rinx/devenv:latest

Add aliases to your shell (they're already described in `zshrc` in this repository).

```sh
# docker
alias devstart='docker run \
    --network host \
    --cap-add=ALL \
    --privileged=false \
    --name rinx-devenv \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.dotfiles:/root/.dotfiles \
    -v $HOME/.gitconfig.local:/root/.gitconfig.local \
    -v $HOME/local:/root/local \
    -v $HOME/tmp:/root/tmp \
    -v $HOME/works:/root/works \
    -v $HOME/Downloads:/root/Downloads \
    -dit rinx/devenv'
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

## Dependencies

### Requires for install
* Git
* wget

### Requires for using
#### Zsh
it is recommended to use GNU coreutils

#### Tmux

#### Vim (it is recommended to use Vim 8.0+ or NeoVim)
##### neovim
- +python3
- `pip3 install neovim`
- it is recommended to use `pyenv` and `pyenv-virtualenv`
    - `pyenv virtualenv 3.x.x neovim3`
    - `pyenv activate neovim3 && pip install neovim`

##### Vim scripts
- radiko.vim
    - mplayer
    - rtmpdump
    - swftools
- w3m (for ref-webdict)

##### Haskell
- ghc-mod: `cabal install ghc-mod`
- hoogle:  `cabal install hoogle`

##### Elm
- elm binaries: `npm install -g elm elm-test elm-oracle elm-format`

##### Clojure
- leiningen: `lein`
- `profiles.clj` is included in this repository.

##### Rust
- use nightly compiler: `rustup default nightly`
- racer: `cargo install racer && rustup component add rust-src`

##### Go
- Execute `:GoInstallBinaries` in vim

##### Swift
- sourcekitten: `brew install sourcekitten`

##### Miscellaneous
- fzf
- ripgrep

#### OSX
##### MacVim 8.0+
- `brew tap universal-ctags/universal-ctags`
- `brew install --HEAD universal-ctags`
- `brew tap splhack/splhack`
- `brew install --HEAD cmigemo-mk`
- `brew install --HEAD --with-properly-linked-python2-python3 macvim-kaoriya`
##### reattach-to-user-namespace

#### Arch linux
##### aurman
- `git clone https://aur.archlinux.org/aurman.git && cd aurman && makepkg -si`

##### WM dependencies
- sway `pacman -S sway`
    - i3status `pacman -S i3status`
- urxvt `pacman -S rxvt-unicode`
- rofi `pacman -S rofi`
- chromium `pacman -S chromium`
- ibus `pacman -S ibus`
    - ibus-skk `pacman -S ibus-skk`

### Troubleshooting

#### vim

##### If ref-webdic does not work correctly

Please check `w3m` is installed correctly.

##### If it takes too long time for searching candidates of haskell import

Please check `ghc-mod` is installed.


## Notation

You can use private configurations by creating following files:

* `~/.vimrc_private`
* `~/.gitconfig.local`

Also, you can use local configurations in each directory by adding following files:

* `.vimrc.local`
* `.latexmkrc`


