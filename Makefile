DOTDIR := \
    ~/.dotfiles

MAKELISTS := Makefile $(shell find Makefile.d -type f -regex ".*\.mk")

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
    init \
    test \
    check-commands

.PHONY: help
## print all available commands
help:
	@awk '/^[a-zA-Z_0-9%:\\\/-]+:/ { \
	  helpMessage = match(lastLine, /^## (.*)/); \
	  if (helpMessage) { \
	    helpCommand = $$1; \
	    helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
      gsub("\\\\", "", helpCommand); \
      gsub(":+$$", "", helpCommand); \
	    printf "  \x1b[32;01m%-35s\x1b[0m %s\n", helpCommand, helpMessage; \
	  } \
	} \
	{ lastLine = $$0 }' $(MAKELISTS) | sort -u
	@printf "\n"

.PHONY: deploy
## make symbolic links to the dotfiles
deploy: \
    prepare-deploy \
    vim-deploy \
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
    vim-init \
    neovim-init
	@$(call green, "initialize stage has been done")

.PHONY: test
## test
test: \
    prepare-test
	@$(call blue, "test stage has been done")

.PHONY: check-commands
## check whether required commands are installed
check-commands: \
    prepare-check-commands
	@$(call blue, "check-commands stage has been done")

.PHONY: clean
## clean all
clean: \
    prepare-clean
	@$(call yellow, "clean stage has been done")

include Makefile.d/*.mk
