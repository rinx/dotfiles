# dotfiles

## files

* .vimrc
* .zshrc
* .tmux.conf
* .gitconfig
* .gitignore
* .xmonad/xmonad.hs
* .gitattributes\_global
* tiny.vimrc (for git-commit editor)
* vimrc\_concatenated.vim (for reading)

### setup scripts

* setup.sh (make symbolic links in `$HOME`)
* vim-ft-setup.sh (make symbolic links in `$HOME/.vim` / called from `setup.sh`)

## install and uninstall

### install

clone this repository

    $ git clone https://github.com/rinx/dotfiles.git ~/.dotfiles

`setup.sh` makes symbolic link in home and gets some scripts, vim plugins

    $ sh setup.sh -af

### uninstall

use `setup.sh` to remove symbolic links

    $ sh setup.sh -ac

### options

to specify what type of dotfiles for installing

|opt | description              |
|:--:|:------------------------:|
| -a | for all type of dotfiles |
| -s | make symbolic links      |
| -v | under `$HOME/.vim` files |
| -t | under `$HOME/.bin` files |
| -x | for xmonad               |

if you have some dotfiles and want to overwrite it, `-f` option is useful.

if you want to clear dotfiles, use `-c` option.


