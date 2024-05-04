DOTDIR := \
    ~/.dotfiles

BINDIR := \
    ~/.bin

UNAME := $(eval UNAME := $(shell uname))$(UNAME)
ARCH :=  $(eval ARCH := $(shell uname -m))$(ARCH)

# color palletes
red    = /bin/echo -e "\x1b[31m\#\# $1\x1b[0m"
green  = /bin/echo -e "\x1b[32m\#\# $1\x1b[0m"
yellow = /bin/echo -e "\x1b[33m\#\# $1\x1b[0m"
blue   = /bin/echo -e "\x1b[34m\#\# $1\x1b[0m"
pink   = /bin/echo -e "\x1b[35m\#\# $1\x1b[0m"
cyan   = /bin/echo -e "\x1b[36m\#\# $1\x1b[0m"

.PHONY: all
## deploy -> init -> install
all: \
    deploy \
    init \
    install

.PHONY: deploy
## make symbolic links to the dotfiles
deploy: \
    prepare-deploy \
    neovim-deploy \
    git-deploy \
    tmux-deploy \
    zsh-deploy \
    others-deploy
	@$(call cyan, "Done: deploy")

.PHONY: init
## initialize all configures
init: \
    prepare-init \
    tmux-init
	@$(call cyan, "Done: initialize")

.PHONY: install
## install binaries
install: \
	install-bins
	@$(call cyan, "Done: install")

include Makefile.d/*.mk
