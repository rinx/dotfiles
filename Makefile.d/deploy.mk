.PHONY: prepare-deploy
prepare-deploy:
	@$(call cyan, "deploy stage")

.PHONY: neovim-deploy
neovim-deploy: \
    init.lua \
    nvim-lua \
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
    commit_template
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

.PHONY: tmux-deploy
tmux-deploy: \
    tmux.conf \
    tpm
	@$(call red, "tmux-deploy has been done")

.PHONY: tmux.conf
tmux.conf: $(HOME)/.tmux.conf
$(HOME)/.tmux.conf:
	@$(call cyan, "--\> tmux.conf")
	ln -s $(DOTDIR)/tmux.conf $(HOME)/.tmux.conf

.PHONY: tpm
tpm: $(HOME)/.tmux/plugins/tpm
$(HOME)/.tmux/plugins/tpm:
	mkdir -p $(HOME)/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm

.PHONY: zsh-deploy
zsh-deploy: \
    zshrc \
    p10k.zsh
	@$(call red, "zsh-deploy has been done")

.PHONY: zshrc
zshrc: $(HOME)/.zshrc
$(HOME)/.zshrc:
	@$(call cyan, "--\> zshrc")
	ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

.PHONY: p10k.zsh
p10k.zsh: $(HOME)/.p10k.zsh
$(HOME)/.p10k.zsh:
	@$(call cyan, "--\> p10k.zsh")
	ln -s $(DOTDIR)/p10k.zsh $(HOME)/.p10k.zsh

.PHONY: others-deploy
others-deploy: \
    kitty.conf \
    Xdefaults \
    rofi-config \
    hyprland-config \
    textlintrc \
    markdownlintrc \
    dotfiles-local \
    macos
	@$(call red, "others-deploy")

.PHONY: kitty.conf
kitty.conf: $(HOME)/.config/kitty/kitty.conf
$(HOME)/.config/kitty/kitty.conf:
	@$(call cyan, "--\> kitty.conf")
	mkdir -p $(HOME)/.config/kitty
	ln -s $(DOTDIR)/kitty.conf $(HOME)/.config/kitty/kitty.conf

.PHONY: Xdefaults
Xdefaults: $(HOME)/.Xdefaults
$(HOME)/.Xdefaults:
	@$(call cyan, "--\> Xdefaults")
	ln -s $(DOTDIR)/Xdefaults $(HOME)/.Xdefaults

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
	$(HOME)/.config/hypr/hypridle.conf \
	$(HOME)/.config/hypr/hyprlock.conf \
	$(HOME)/.config/waybar/config.jsonc \
	$(HOME)/.config/waybar/style.css
$(HOME)/.config/hypr/hyprland.conf:
	mkdir -p $(HOME)/.config/hypr
	ln -s $(DOTDIR)/hyprland.conf $(HOME)/.config/hypr/hyprland.conf
$(HOME)/.config/hypr/hypridle.conf:
	mkdir -p $(HOME)/.config/hypr
	ln -s $(DOTDIR)/hypridle.conf $(HOME)/.config/hypr/hypridle.conf
$(HOME)/.config/hypr/hyprlock.conf:
	mkdir -p $(HOME)/.config/hypr
	ln -s $(DOTDIR)/hyprlock.conf $(HOME)/.config/hypr/hyprlock.conf
$(HOME)/.config/waybar/config.jsonc:
	mkdir -p $(HOME)/.config/waybar
	ln -s $(DOTDIR)/waybar-config.jsonc $(HOME)/.config/waybar/config.jsonc
$(HOME)/.config/waybar/style.css:
	mkdir -p $(HOME)/.config/waybar
	ln -s $(DOTDIR)/waybar-style.css $(HOME)/.config/waybar/style.css
endif

.PHONY: wallpapers
wallpapers: \
    $(HOME)/.wallpapers/pexels-photo-15286.jpg \
    $(HOME)/.wallpapers/pexels-photo-2559941.jpg \
    $(HOME)/.wallpapers/pexels-photo-417074.jpg \
    $(HOME)/.wallpapers/pexels-photo-167699.jpg \
    $(HOME)/.wallpapers/pexels-photo-531321.jpg \
    $(HOME)/.wallpapers/pexels-photo-460621.jpg \
    $(HOME)/.wallpapers/pexels-photo-2049422.jpg \
    $(HOME)/.wallpapers/pexels-photo-635279.jpg \
    $(HOME)/.wallpapers/pexels-photo-1933239.jpg
$(HOME)/.wallpapers/pexels-photo-15286.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/15286/pexels-photo.jpg --output $(HOME)/.wallpapers/pexels-photo-15286.jpg
$(HOME)/.wallpapers/pexels-photo-2559941.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/2559941/pexels-photo-2559941.jpeg --output $(HOME)/.wallpapers/pexels-photo-2559941.jpg
$(HOME)/.wallpapers/pexels-photo-417074.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg --output $(HOME)/.wallpapers/pexels-photo-417074.jpg
$(HOME)/.wallpapers/pexels-photo-167699.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg --output $(HOME)/.wallpapers/pexels-photo-167699.jpg
$(HOME)/.wallpapers/pexels-photo-531321.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/531321/pexels-photo-531321.jpeg --output $(HOME)/.wallpapers/pexels-photo-531321.jpg
$(HOME)/.wallpapers/pexels-photo-460621.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/460621/pexels-photo-460621.jpeg --output $(HOME)/.wallpapers/pexels-photo-460621.jpg
$(HOME)/.wallpapers/pexels-photo-2049422.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/2049422/pexels-photo-2049422.jpeg --output $(HOME)/.wallpapers/pexels-photo-2049422.jpg
$(HOME)/.wallpapers/pexels-photo-635279.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/635279/pexels-photo-635279.jpeg --output $(HOME)/.wallpapers/pexels-photo-635279.jpg
$(HOME)/.wallpapers/pexels-photo-1933239.jpg:
	mkdir -p $(HOME)/.wallpapers
	curl -sL https://images.pexels.com/photos/1933239/pexels-photo-1933239.jpeg --output $(HOME)/.wallpapers/pexels-photo-1933239.jpg

.PHONY: i3status-config
i3status-config: \
    $(HOME)/.config/i3status/config
$(HOME)/.config/i3status/config:
	mkdir -p $(HOME)/.config/i3status
	ln -s $(DOTDIR)/i3status-config $(HOME)/.config/i3status/config

.PHONY: markdownlintrc
markdownlintrc: $(HOME)/.markdownlintrc
$(HOME)/.markdownlintrc:
	ln -s $(DOTDIR)/markdownlintrc $(HOME)/.markdownlintrc

.PHONY: textlintrc
textlintrc: $(HOME)/.textlintrc
$(HOME)/.textlintrc:
	ln -s $(DOTDIR)/textlintrc $(HOME)/.textlintrc

.PHONY: dotfiles-local
dotfiles-local: \
	$(HOME)/.dotfiles.local \
	$(HOME)/.gitconfig.local \
	$(HOME)/.git-profiles.edn \
	$(HOME)/.skk-jisyo

$(HOME)/.dotfiles.local:
	mkdir -p $(HOME)/.dotfiles.local

$(HOME)/.gitconfig.local:
	touch $(HOME)/.dotfiles.local/gitconfig.local
	ln -s $(HOME)/.dotfiles.local/gitconfig.local $(HOME)/.gitconfig.local

$(HOME)/.git-profiles.edn:
	touch $(HOME)/.dotfiles.local/git-profiles.edn
	ln -s $(HOME)/.dotfiles.local/git-profiles.edn $(HOME)/.git-profiles.edn

$(HOME)/.skk-jisyo:
	touch $(HOME)/.dotfiles.local/skk-jisyo
	ln -s $(HOME)/.dotfiles.local/skk-jisyo $(HOME)/.skk-jisyo

ifeq ($(UNAME),Darwin)
.PHONY: macos
macos: \
	yabairc \
	sketchybar \
	skhdrc
	@$(call green, "macos-deploy")
else
.PHONY: macos
macos:
	@$(call green, "macos: nothing to do")
endif

.PHONY: yabairc
yabairc: $(HOME)/.yabairc
$(HOME)/.yabairc:
	@$(call cyan, "--\> .yabairc")
	ln -s $(DOTDIR)/macos/yabairc $(HOME)/.yabairc

.PHONY: sketchybar
sketchybar: $(HOME)/.config/sketchybar
$(HOME)/.config/sketchybar:
	@$(call cyan, "--\> $(HOME)/.config/sketchybar")
	ln -s $(DOTDIR)/macos/sketchybar $(HOME)/.config/sketchybar

.PHONY: skhdrc
skhdrc: $(HOME)/.skhdrc
$(HOME)/.skhdrc:
	@$(call cyan, "--\> .skhdrc")
	ln -s $(DOTDIR)/macos/skhdrc $(HOME)/.skhdrc
