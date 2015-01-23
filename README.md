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


