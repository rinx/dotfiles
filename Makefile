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

# color palletes
red    = /bin/echo -e "\x1b[31m\#\# $1\x1b[0m"
green  = /bin/echo -e "\x1b[32m\#\# $1\x1b[0m"
yellow = /bin/echo -e "\x1b[33m\#\# $1\x1b[0m"
blue   = /bin/echo -e "\x1b[34m\#\# $1\x1b[0m"
pink   = /bin/echo -e "\x1b[35m\#\# $1\x1b[0m"
cyan   = /bin/echo -e "\x1b[36m\#\# $1\x1b[0m"

all: \
    deploy \
    init \
    test \
    check-commands

# make symbolic links to the dotfiles
deploy: \
    prepare-deploy \
    vim-deploy \
    git-deploy \
    tmux-deploy \
    zsh-deploy \
    others-deploy
	@$(call cyan, "deploy stage has been done")
	# sh setup.sh -af


# initialize all configures
init: \
    prepare-init \
    vim-init \
    tmux-init
	@$(call green, "initialize stage has been done")

test: \
    prepare-test
	@$(call blue, "test stage has been done")

# check whether required commands are installed
check-commands: \
    prepare-check-commands
	@$(call blue, "check-commands stage has been done")

clean: \
    prepare-clean
	@$(call yellow, "clean stage has been done")
	# sh setup.sh -ac

# deploy

prepare-deploy:
	@$(call cyan, "deploy stage")

vim-deploy:
	@$(call red, "vim-deploy")
	# ln -s $(DOTDIR)/vimrc $(HOME)/.vimrc
	# ln -s $(DOTDIR)/vimshrc $(HOME)/.vimshrc
	@$(call green, "install dein for Vim")
	# mkdir -p $HOME/.vim/dein/repos/github.com/Shougo
	# git clone https://github.com/Shougo/dein.vim $HOME/.vim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1

neovim-deploy:
	@$(call red, "neovim-deploy")
	# mkdir -p $HOME/.config/nvim
	# ln -s $DOTDIR/nvimrc $HOME/.config/nvim/init.vim
	@$(call green, "install dein for NeoVim")
	# mkdir -p $HOME/.config/nvim/dein/repos/github.com/Shougo
	# git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1

git-deploy:
	@$(call red, "git-deploy")
	# ln -s $(DOTDIR)/gitconfig $(HOME)/.gitconfig
	# ln -s $(DOTDIR)/gitignore $(HOME)/.gitignore
	# ln -s $(DOTDIR)/gitattributes_global $(HOME)/.gitattributes_global

tmux-deploy:
	@$(call red, "tmux-deploy")
	# ln -s $(DOTDIR)/tmux.conf $(HOME)/.tmux.conf
	@$(call green, "tmux plugin manager")
	# mkdir -p $HOME/.tmux
	# ln -s $DOTDIR/dottmux/plugins $HOME/.tmux/plugins

zsh-deploy:
	@$(call red, "zsh-deploy")
	# ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

others-deploy:
	@$(call red, "others-deploy")
	# ln -s $(DOTDIR)/latexmkrc $(HOME)/.latexmkrc

# init
prepare-init:
	@$(call green, "initialize stage")

vim-init:
	@$(call red, "vim-init")
	@$(call blue, "initialize dein for Vim")
	# vim -N -u NONE -i NONE -V1 -e -s --cmd "source $DOTDIR/vimrc" --cmd 'call dein#install()' --cmd quit

neovim-init:
	@$(call red, "neovim-init")
	@$(call blue, "initialize dein for NeoVim")
	# nvim -N -u NONE -i NONE -V1 -e -s --cmd "source $DOTDIR/vimrc" --cmd 'call dein#install()' --cmd quit

tmux-init:
	@$(call red, "tmux-init")
	# git submodule update --init

# test
prepare-test:
	@$(call blue, "test stage")

# check-commands
prepare-check-commands:
	@$(call blue, "check-commands stage")

# clean
prepare-clean:
	@$(call yellow, "clean stage")

