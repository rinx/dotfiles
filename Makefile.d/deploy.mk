.PHONY: prepare-deploy
prepare-deploy:
	@$(call cyan, "deploy stage")

.PHONY: neovim-deploy
neovim-deploy: \
    init.lua \
    nvim-lua \
    nvim-snippets \
    nvim-org \
    lazy-lock \
    skk-jisyo-large
	@$(call red, "neovim-deploy has been done")

.PHONY: init.lua
init.lua: $(HOME)/.config/nvim/init.lua
$(HOME)/.config/nvim/init.lua:
	@$(call cyan, "--\> init.lua")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/init.lua $(HOME)/.config/nvim/init.lua

.PHONY: nvim-lua
nvim-lua: $(HOME)/.config/nvim/lua
$(HOME)/.config/nvim/lua:
	@$(call cyan, "--\> nvim/lua directory for nvim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/lua $(HOME)/.config/nvim/lua

.PHONY: nvim-snippets
nvim-snippets: $(HOME)/.config/nvim/snippets
$(HOME)/.config/nvim/snippets:
	@$(call cyan, "--\> nvim/snippets directory for nvim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/snippets $(HOME)/.config/nvim/snippets

.PHONY: nvim-org
nvim-org: $(HOME)/.config/nvim/orgmode
$(HOME)/.config/nvim/orgmode:
	@$(call cyan, "--\> nvim/orgmode directory for nvim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/orgmode $(HOME)/.config/nvim/orgmode

.PHONY: lazy-lock
lazy-lock: $(HOME)/.config/nvim/lazy-lock.json
$(HOME)/.config/nvim/lazy-lock.json:
	@$(call cyan, "--\> lazy-lock.json for nvim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/lazy-lock.json $(HOME)/.config/nvim/lazy-lock.json

.PHONY: skk-jisyo-large
skk-jisyo-large: $(HOME)/.SKK-JISYO.L
$(HOME)/.SKK-JISYO.L:
	@$(call cyan, "--\> download SKK-JISYO.L")
	curl -sL https://raw.githubusercontent.com/skk-users-jp/dic-mirror/gh-pages/SKK-JISYO.L --output $(HOME)/.SKK-JISYO.L

.PHONY: git-deploy
git-deploy: \
    gitconfig \
    gitignore \
    gitattributes \
    commit_template \
    gitlint
	@$(call red, "git-deploy")

.PHONY: gitconfig
gitconfig: $(HOME)/.gitconfig
$(HOME)/.gitconfig:
	@$(call cyan, "--\> gitconfig")
	ln -s $(DOTDIR)/gitconfig $(HOME)/.gitconfig

.PHONY: gitignore
gitignore: $(HOME)/.gitignore
$(HOME)/.gitignore:
	@$(call cyan, "--\> gitignore")
	ln -s $(DOTDIR)/gitignore $(HOME)/.gitignore

.PHONY: gitattributes
gitattributes: $(HOME)/.gitattributes_global
$(HOME)/.gitattributes_global:
	@$(call cyan, "--\> gitattributes_global")
	ln -s $(DOTDIR)/gitattributes_global $(HOME)/.gitattributes_global

.PHONY: commit_template
commit_template: $(HOME)/.commit_template
$(HOME)/.commit_template:
	@$(call cyan, "--\> .commit_template")
	ln -s $(DOTDIR)/.commit_template $(HOME)/.commit_template

.PHONY: gitlint
gitlint: $(HOME)/.gitlint
$(HOME)/.gitlint:
	@$(call cyan, "--\> .gitlint")
	ln -s $(DOTDIR)/.gitlint $(HOME)/.gitlint

.PHONY: zsh-deploy
zsh-deploy: \
    zshrc \
    zshrc.d \
    p10k.zsh
	@$(call red, "zsh-deploy has been done")

.PHONY: zshrc
zshrc: $(HOME)/.zshrc
$(HOME)/.zshrc:
	@$(call cyan, "--\> zshrc")
	ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

.PHONY: zshrc.d
zshrc.d: $(HOME)/.config/zsh/rc
$(HOME)/.config/zsh/rc:
	@$(call cyan, "--\> zshrc.d")
	mkdir -p $(HOME)/.config/zsh
	ln -s $(DOTDIR)/zshrc.d $(HOME)/.config/zsh/rc

.PHONY: p10k.zsh
p10k.zsh: $(HOME)/.p10k.zsh
$(HOME)/.p10k.zsh:
	@$(call cyan, "--\> p10k.zsh")
	ln -s $(DOTDIR)/p10k.zsh $(HOME)/.p10k.zsh

.PHONY: others-deploy
others-deploy: \
    kitty.conf \
    rofi-config \
    hyprland-config \
    dotfiles-local \
    macos
	@$(call red, "others-deploy")

.PHONY: kitty.conf
kitty.conf: $(HOME)/.config/kitty/kitty.conf
$(HOME)/.config/kitty/kitty.conf:
	@$(call cyan, "--\> kitty.conf")
	mkdir -p $(HOME)/.config/kitty
	ln -s $(DOTDIR)/kitty.conf $(HOME)/.config/kitty/kitty.conf

.PHONY: rofi-config
rofi-config: \
	$(HOME)/.config/rofi/config.rasi
$(HOME)/.config/rofi/config.rasi:
	mkdir -p $(HOME)/.config/rofi
	ln -s $(DOTDIR)/resources/config.rasi $(HOME)/.config/rofi/config.rasi

ifeq ($(UNAME),Darwin)
.PHONY: hyprland-config
hyprland-config:
	@$(call green, "hyprland-config: nothing to do")
else
.PHONY: hyprland-config
hyprland-config: \
	$(HOME)/.config/hypr/hyprland.conf \
	$(HOME)/.config/hypr/hyprland.local.conf \
	$(HOME)/.config/hypr/hypridle.conf \
	$(HOME)/.config/hypr/hyprlock.conf \
	$(HOME)/.config/waybar/config.jsonc \
	$(HOME)/.config/waybar/style.css
$(HOME)/.config/hypr/hyprland.conf:
	mkdir -p $(HOME)/.config/hypr
	ln -s $(DOTDIR)/hypr/hyprland.conf $(HOME)/.config/hypr/hyprland.conf
$(HOME)/.config/hypr/hyprland.local.conf:
	mkdir -p $(HOME)/.config/hypr
	touch $(HOME)/.config/hypr/hyprland.local.conf
$(HOME)/.config/hypr/hypridle.conf:
	mkdir -p $(HOME)/.config/hypr
	ln -s $(DOTDIR)/hypr/hypridle.conf $(HOME)/.config/hypr/hypridle.conf
$(HOME)/.config/hypr/hyprlock.conf:
	mkdir -p $(HOME)/.config/hypr
	ln -s $(DOTDIR)/hypr/hyprlock.conf $(HOME)/.config/hypr/hyprlock.conf
$(HOME)/.config/waybar/config.jsonc:
	mkdir -p $(HOME)/.config/waybar
	ln -s $(DOTDIR)/waybar/config.jsonc $(HOME)/.config/waybar/config.jsonc
$(HOME)/.config/waybar/style.css:
	mkdir -p $(HOME)/.config/waybar
	ln -s $(DOTDIR)/waybar/style.css $(HOME)/.config/waybar/style.css
endif

.PHONY: i3status-config
i3status-config: \
    $(HOME)/.config/i3status/config
$(HOME)/.config/i3status/config:
	mkdir -p $(HOME)/.config/i3status
	ln -s $(DOTDIR)/i3status-config $(HOME)/.config/i3status/config

.PHONY: dotfiles-local
dotfiles-local: \
	$(HOME)/.dotfiles.local \
	$(HOME)/.dotfiles.local/gitconfig.local \
	$(HOME)/.dotfiles.local/git-profiles.edn \
	$(HOME)/.dotfiles.local/skk-jisyo

$(HOME)/.dotfiles.local:
	mkdir -p $(HOME)/.dotfiles.local

$(HOME)/.dotfiles.local/gitconfig.local: $(HOME)/.dotfiles.local
	touch $(HOME)/.dotfiles.local/gitconfig.local

$(HOME)/.dotfiles.local/git-profiles.edn: $(HOME)/.dotfiles.local
	touch $(HOME)/.dotfiles.local/git-profiles.edn

$(HOME)/.dotfiles.local/skk-jisyo: $(HOME)/.dotfiles.local
	touch $(HOME)/.dotfiles.local/skk-jisyo

ifeq ($(UNAME),Darwin)
.PHONY: macos
macos: \
	aerospace \
	sketchybar
	@$(call green, "macos-deploy")
else
.PHONY: macos
macos:
	@$(call green, "macos: nothing to do")
endif

.PHONY: aerospace
aerospace: $(HOME)/.aerospace.toml
$(HOME)/.aerospace.toml:
	@$(call cyan, "--\> .aerospace.toml")
	ln -s $(DOTDIR)/macos/aerospace.toml $(HOME)/.aerospace.toml

.PHONY: sketchybar
sketchybar: $(HOME)/.config/sketchybar
$(HOME)/.config/sketchybar:
	@$(call cyan, "--\> $(HOME)/.config/sketchybar")
	ln -s $(DOTDIR)/macos/sketchybar $(HOME)/.config/sketchybar
