.PHONY: prepare-init
prepare-init:
	@$(call green, "initialize stage")

.PHONY: neovim-init
neovim-init:
	@$(call red, "neovim-init")
	@$(call blue, "--\> initialize neovim")
	nvim +"au User PackerComplete qa" +PackerSync

.PHONY: tmux-init
tmux-init:
	@$(call red, "tmux-init")
	@$(call blue, "--\> install tmux plugins")
	bash $(HOME)/.tmux/plugins/tpm/scripts/install_plugins.sh
