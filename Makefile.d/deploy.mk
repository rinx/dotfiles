.PHONY: prepare-deploy
prepare-deploy:
	@$(call cyan, "deploy stage")

.PHONY: neovim-deploy
neovim-deploy: \
    init.lua \
    nvim-fnl \
    skk-jisyo-large
	@$(call red, "neovim-deploy has been done")

.PHONY: init.lua
init.lua: $(HOME)/.config/nvim/init.lua
$(HOME)/.config/nvim/init.lua:
	@$(call cyan, "--\> init.lua")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/init.lua $(HOME)/.config/nvim/init.lua

.PHONY: nvim-fnl
nvim-fnl: $(HOME)/.config/nvim/fnl
$(HOME)/.config/nvim/fnl:
	@$(call cyan, "--\> nvim/fnl directory for nvim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/fnl $(HOME)/.config/nvim/fnl

.PHONY: skk-jisyo-large
skk-jisyo-large: $(HOME)/.SKK-JISYO.L
$(HOME)/.SKK-JISYO.L:
	@$(call cyan, "--\> download SKK-JISYO.L")
	curl -sL https://raw.githubusercontent.com/skk-users-jp/dic-mirror/gh-pages/SKK-JISYO.L --output $(HOME)/.SKK-JISYO.L

.PHONY: git-deploy
git-deploy: \
    gitconfig \
    gitconfig-local \
    gitignore \
    gitattributes \
    commit_template \
    devmojis
	@$(call red, "git-deploy")

.PHONY: gitconfig
gitconfig: $(HOME)/.gitconfig
$(HOME)/.gitconfig:
	@$(call cyan, "--\> gitconfig")
	ln -s $(DOTDIR)/gitconfig $(HOME)/.gitconfig

.PHONY: gitconfig-local
gitconfig-local: $(HOME)/.gitconfig.local
$(HOME)/.gitconfig.local:
	@$(call cyan, "--\> gitconfig.local")
	touch $(HOME)/.gitconfig.local

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

.PHONY: devmojis
devmojis: $(HOME)/.devmojis
$(HOME)/.devmojis:
	@$(call cyan, "--\> devmojis")
	ln -s $(DOTDIR)/resources/devmojis $(HOME)/.devmojis

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
    zshrc
	@$(call red, "zsh-deploy has been done")

.PHONY: zshrc
zshrc: $(HOME)/.zshrc
$(HOME)/.zshrc:
	@$(call cyan, "--\> zshrc")
	ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

.PHONY: others-deploy
others-deploy: \
    alacritty.yml \
    kitty.conf \
    Xdefaults \
    rofi-config \
    sway-config \
    i3status-config \
    lein-profile \
    deps-edn \
    textlintrc \
    markdownlintrc \
    hyper
	@$(call red, "others-deploy")

.PHONY: alacritty.yml
alacritty.yml: $(HOME)/.alacritty.yml
$(HOME)/.alacritty.yml:
	@$(call cyan, "--\> alacritty.yml")
	ln -s $(DOTDIR)/alacritty.yml $(HOME)/.alacritty.yml

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

.PHONY: sway-config
sway-config: \
    $(HOME)/.config/sway/config
$(HOME)/.config/sway/config:
	mkdir -p $(HOME)/.config/sway
	ln -s $(DOTDIR)/sway-config $(HOME)/.config/sway/config

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

.PHONY: lein-profile
lein-profile: $(HOME)/.lein/profiles.clj
$(HOME)/.lein/profiles.clj:
	mkdir -p $(HOME)/.lein
	ln -s $(DOTDIR)/profiles.clj $(HOME)/.lein/profiles.clj

.PHONY: deps-edn
deps-edn: $(HOME)/.clojure/deps.edn
$(HOME)/.clojure/deps.edn:
	mkdir -p $(HOME)/.clojure
	ln -s $(DOTDIR)/deps.edn $(HOME)/.clojure/deps.edn

.PHONY: markdownlintrc
markdownlintrc: $(HOME)/.markdownlintrc
$(HOME)/.markdownlintrc:
	ln -s $(DOTDIR)/markdownlintrc $(HOME)/.markdownlintrc

.PHONY: textlintrc
textlintrc: $(HOME)/.textlintrc
$(HOME)/.textlintrc:
	ln -s $(DOTDIR)/textlintrc $(HOME)/.textlintrc

.PHONY: hyper
hyper: $(HOME)/.hyper.js
$(HOME)/.hyper.js:
	ln -s $(DOTDIR)/hyper.js $(HOME)/.hyper.js
