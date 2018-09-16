# dotfiles

## files

* .vimrc
* .zshrc
* .tmux.conf
* .gitconfig
* .gitignore
* .xmonad/xmonad.hs
* .config/sway/config
* .gitattributes\_global
* .latexmkrc
* tiny.vimrc (for git-commit editor)
* .vimshrc
* .lein/profiles.clj
* .Xdefaults

### directories

* dotvim (will be linked to `$HOME/.vim`)

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
Plugins (for install: `prefix + I`)

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
    - libqalculate `pacman -S libqalculate`
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


