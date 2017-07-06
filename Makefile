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
	# ln -s $(DOTDIR)/vimrc $(HOME)/.vimrc
	# ln -s $(DOTDIR)/vimshrc $(HOME)/.vimshrc

git-deploy:
	echo "git"
	# ln -s $(DOTDIR)/gitconfig $(HOME)/.gitconfig
	# ln -s $(DOTDIR)/gitignore $(HOME)/.gitignore
	# ln -s $(DOTDIR)/gitattributes_global $(HOME)/.gitattributes_global

tmux-deploy:
	echo "tmux"
	# ln -s $(DOTDIR)/tmux.conf $(HOME)/.tmux.conf

zsh-deploy:
	echo "zsh"
	# ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

others-deploy:
	echo "others"
	# ln -s $(DOTDIR)/latexmkrc $(HOME)/.latexmkrc

# init

vim-init:
	# install dein

tmux-init:
	# git submodule update --init


