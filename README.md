# dotfiles

## files

* .vimrc
* .zshrc
* .tmux.conf
* .gitconfig
* .gitignore
* .gitattributes\_global
* .latexmkrc
* tiny.vimrc (for git-commit editor)
* .vimshrc

### directories

* dotvim (will be linked to `$HOME/.vim`)
* dottmux (will be linked to `$HOME/.tmux`)

### setup scripts

* setup.sh (make symbolic links in `$HOME`)
* vim-ft-setup.sh (make symbolic links in `$HOME/.vim` / called from `setup.sh`)

## install and uninstall

### install

clone this repository

    $ git clone https://github.com/rinx/dotfiles.git ~/.dotfiles

then, clone submodules

    $ git submodule update --init

`setup.sh` makes symbolic link in home and gets some scripts, vim plugins

    $ sh setup.sh -af

### uninstall

use `setup.sh` to remove symbolic links

    $ sh setup.sh -ac

### options

to specify what type of dotfiles for installing

|opt | description                                         |
|:--:|:----------------------------------------------------|
| -a | for all type of dotfiles                            |
| -s | make symbolic links                                 |
| -v | link `$HOME/.vim` files                             |
| -t | fetch `$HOME/.bin` files / link `$HOME/.tmux` files |

if you have some dotfiles and want to overwrite it, `-f` option is useful.

if you want to clear dotfiles, use `-c` option.


## Dependencies

### Requires for install
* Git
* wget

### Requires for using
* Zsh
* Tmux
    - Plugins (for install: `prefix + I`)
* Vim
    - Vim scripts
    - Haskell
        - ghc-mod `cabal install ghc-mod`
        - hoogle  `cabal install hoogle`
    - Elm
        - npm install -g elm elm-test elm-oracle
    - Miscellaneous
        - w3m (for ref-webdict)
* OSX
    - MacVim
    - reattach-to-user-namespace

### Troubleshooting

#### vim

##### If ref-webdic does not work correctly

Please check `w3m` is installed correctly.

##### If it takes too long time for searching candidates of haskell import

Please check `ghc-mod` is installed.


