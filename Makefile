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
C_WHITE := "\033[00m"
C_RED := "\033[0;31m"
C_GREEN := "\033[0;32m"
C_YELLOW := "\033[0;33m"
C_BLUE := "\033[0;34m"
C_PINK := "\033[0;35m"
C_CYAN := "\033[0;36m"
C_RED2 := "\033[1;31m"
C_GREEN2 := "\033[1;32m"
C_YELLOW2 := "\033[1;33m"
C_BLUE2:= "\033[1;34m"
C_PINK2 := "\033[1;35m"
C_CYAN2 := "\033[1;36m"

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
	@echo "==="
	@echo "deploy stage has been done"
	@echo "==="
	@echo
	# sh setup.sh -af


# initialize all configures
init: \
    prepare-init \
    vim-init \
    tmux-init
	@echo "==="
	@echo "initialize stage has been done"
	@echo "==="
	@echo

test: \
    prepare-test
	@echo "==="
	@echo "test stage has been done"
	@echo "==="
	@echo

# check whether required commands are installed
check-commands: \
    prepare-check-commands
	@echo "==="
	@echo "check-commands stage has been done"
	@echo "==="


clean: \
    prepare-clean
	@echo "==="
	@echo "clean stage has been done"
	@echo "==="
	# sh setup.sh -ac

# deploy

prepare-deploy:
	@echo "==="
	@echo "deploy stage"
	@echo "==="

vim-deploy:
	@echo "vim-deploy"
	@echo "==="
	# ln -s $(DOTDIR)/vimrc $(HOME)/.vimrc
	# ln -s $(DOTDIR)/vimshrc $(HOME)/.vimshrc
	@echo "install dein for Vim"
	@echo "---"

neovim-deploy:
	@echo "neovim-deploy"
	@echo "==="
	@echo "install dein for NeoVim"
	@echo "---"

git-deploy:
	@echo "git-deploy"
	@echo "==="
	# ln -s $(DOTDIR)/gitconfig $(HOME)/.gitconfig
	# ln -s $(DOTDIR)/gitignore $(HOME)/.gitignore
	# ln -s $(DOTDIR)/gitattributes_global $(HOME)/.gitattributes_global

tmux-deploy:
	@echo "tmux-deploy"
	@echo "==="
	# ln -s $(DOTDIR)/tmux.conf $(HOME)/.tmux.conf
	@echo "tmux plugin manager"
	@echo "---"
	@echo "getipaddr binary"
	@echo "---"

zsh-deploy:
	@echo "zsh-deploy"
	@echo "==="
	# ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

others-deploy:
	@echo "others-deploy"
	@echo "==="
	# ln -s $(DOTDIR)/latexmkrc $(HOME)/.latexmkrc

# init
prepare-init:
	@echo "==="
	@echo "initialize stage"
	@echo "==="

vim-init:
	@echo "vim-init"
	@echo "==="
	@echo "initialize dein for Vim"
	@echo "---"

neovim-init:
	@echo "neovim-init"
	@echo "==="
	@echo "initialize dein for NeoVim"
	@echo "---"

tmux-init:
	@echo "tmux-init"
	@echo "==="
	# git submodule update --init

# test
prepare-test:
	@echo "==="
	@echo "test stage"
	@echo "==="

# check-commands
prepare-check-commands:
	@echo "==="
	@echo "check-commands stage"
	@echo "==="

# clean
prepare-clean:
	@echo "==="
	@echo "clean stage"
	@echo "==="

