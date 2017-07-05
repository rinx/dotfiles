# this Makefile is just a draft!!
DOTDIR := \
    ~/.dotfiles
DOTFILES := \
    vimrc \
    zshrc \
    tmux.conf \
    gitconfig \
    gitignore \
    gitattributes_global \
    latexmkrc \
    vimshrc


all: \
    deploy \
    init

# make symbolic links to the dotfiles
deploy: \
    vim-deploy \
    git-deploy \
    tmux-deploy \
    zsh-deploy \
    others-deploy
	# sh setup.sh -af


# initialize all configures
init: \
    vim-init \
    tmux-init


test:


# check whether required commands are installed
check-commands:


clean:
	# sh setup.sh -ac

# deploy

vim-deploy:
	echo "vim"

git-deploy:
	echo "git"

tmux-deploy:
	echo "tmux"

zsh-deploy:
	echo "zsh"

others-deploy:
	echo "others"

# init

vim-init:
	# install dein

tmux-init:
	# git submodule update --init


