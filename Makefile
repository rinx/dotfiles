DOTDIR := \
    ~/.dotfiles

# color palletes
red    = /bin/echo -e "\x1b[31m\#\# $1\x1b[0m"
green  = /bin/echo -e "\x1b[32m\#\# $1\x1b[0m"
yellow = /bin/echo -e "\x1b[33m\#\# $1\x1b[0m"
blue   = /bin/echo -e "\x1b[34m\#\# $1\x1b[0m"
pink   = /bin/echo -e "\x1b[35m\#\# $1\x1b[0m"
cyan   = /bin/echo -e "\x1b[36m\#\# $1\x1b[0m"

.PHONY: all
## deploy -> init -> test -> check
all: \
    deploy \
    init

.PHONY: deploy
## make symbolic links to the dotfiles
deploy: \
    prepare-deploy \
    neovim-deploy \
    git-deploy \
    tmux-deploy \
    zsh-deploy \
    others-deploy
	@$(call cyan, "deploy stage has been done")

.PHONY: init
## initialize all configures
init: \
    prepare-init \
    tmux-init \
    neovim-init
	@$(call green, "initialize stage has been done")

include Makefile.d/*.mk
