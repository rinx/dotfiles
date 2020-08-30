.PHONY: prepare-init
prepare-init:
	@$(call green, "initialize stage")

.PHONY: vim-init
vim-init:
	@$(call red, "vim-init")
	@$(call blue, "--\> initialize dein for Vim")
	vim -N -u NONE -i NONE -V1 -e -s --cmd "source $(DOTDIR)/vimrc" --cmd 'call dein#install()' --cmd quit

.PHONY: neovim-init
neovim-init:
	@$(call red, "neovim-init")
	@$(call blue, "--\> initialize dein for NeoVim")
	nvim --headless +'PlugInstall --sync' +qa
	nvim --headless +'UpdateRemotePlugins' +qa

.PHONY: tmux-init
tmux-init:
	@$(call red, "tmux-init")
	@$(call blue, "--\> install tmux plugins")
	bash $(HOME)/.tmux/plugins/tpm/scripts/install_plugins.sh
