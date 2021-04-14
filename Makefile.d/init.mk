.PHONY: prepare-init
prepare-init:
	@$(call green, "initialize stage")

.PHONY: neovim-init
neovim-init:
	@$(call red, "neovim-init")
	@$(call blue, "--\> initialize neovim")
	rm -rf $HOME/.local/share/nvim $HOME/.config/nvim/lua
	nvim +"au User PackerComplete qa" +PackerSync

.PHONY: tmux-init
tmux-init:
	@$(call red, "tmux-init")
	@$(call blue, "--\> install tmux plugins")
	bash $(HOME)/.tmux/plugins/tpm/scripts/install_plugins.sh
