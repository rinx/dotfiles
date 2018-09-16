.PHONY: \
    prepare-init \
    vim-init \
    neovim-init \
    tmux-init

prepare-init:
	@$(call green, "initialize stage")

vim-init:
	@$(call red, "vim-init")
	@$(call blue, "--\> initialize dein for Vim")
	vim -N -u NONE -i NONE -V1 -e -s --cmd "source $(DOTDIR)/vimrc" --cmd 'call dein#install()' --cmd quit

neovim-init:
	@$(call red, "neovim-init")
	@$(call blue, "--\> initialize dein for NeoVim")
	nvim -N -u NONE -i NONE -V1 -e -s --cmd "source $(DOTDIR)/vimrc" --cmd 'call dein#install()' --cmd quit

tmux-init:
	@$(call red, "tmux-init")
	@$(call blue, "--\> install tmux plugins")
	sh $(HOME)/.tmux/plugins/tpm/scripts/install_plugins.sh

