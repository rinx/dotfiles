.PHONY: prepare-deploy
prepare-deploy:
	@$(call cyan, "deploy stage")

.PHONY: vim-deploy
vim-deploy: \
    vim-ftplugins \
    vim-ftdetects \
    vim-snippets \
    vim-indents \
    dein-vim \
    skk-jisyo-large
	@$(call red, "vim-deploy has been done")

.PHONY: dein-vim
dein-vim: $(HOME)/.vim/dein/repos/github.com/Shougo/dein.vim
$(HOME)/.vim/dein/repos/github.com/Shougo/dein.vim:
	@$(call cyan, "--\> dein.vim")
	mkdir -p $(HOME)/.vim/dein/repos/github.com/Shougo
	git clone https://github.com/Shougo/dein.vim $(HOME)/.vim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1

.PHONY: neovim-deploy
neovim-deploy: \
    init.vim \
    nvim-fnl \
    coc-settings.json \
    skk-jisyo-large
	@$(call red, "neovim-deploy has been done")

.PHONY: init.vim
init.vim: $(HOME)/.config/nvim/init.vim
$(HOME)/.config/nvim/init.vim:
	@$(call cyan, "--\> init.vim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/init.vim $(HOME)/.config/nvim/init.vim

.PHONY: nvim-fnl
nvim-fnl: $(HOME)/.config/nvim/fnl
$(HOME)/.config/nvim/fnl:
	@$(call cyan, "--\> nvim/fnl directory for nvim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/fnl $(HOME)/.config/nvim/fnl

.PHONY: coc-settings.json
coc-settings.json: $(HOME)/.config/nvim/coc-settings.json
$(HOME)/.config/nvim/coc-settings.json:
	@$(call cyan, "--\> coc-settings.json for nvim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvim/coc-settings.json $(HOME)/.config/nvim/coc-settings.json

.PHONY: skk-jisyo-large
skk-jisyo-large: $(HOME)/.SKK-JISYO.L
$(HOME)/.SKK-JISYO.L:
	@$(call cyan, "--\> download SKK-JISYO.L")
	wget -O $(HOME)/.SKK-JISYO.L https://raw.githubusercontent.com/skk-users-jp/dic-mirror/gh-pages/SKK-JISYO.L

.PHONY: git-deploy
git-deploy: \
    gitconfig \
    gitconfig-local \
    gitignore \
    gitattributes
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
    Xdefaults \
    sway-config \
    i3status-config \
    lein-profile \
    deps-edn \
    hyper
	@$(call red, "others-deploy")

.PHONY: alacritty.yml
alacritty.yml: $(HOME)/.alacritty.yml
$(HOME)/.alacritty.yml:
	@$(call cyan, "--\> alacritty.yml")
	ln -s $(DOTDIR)/alacritty.yml $(HOME)/.alacritty.yml

.PHONY: Xdefaults
Xdefaults: $(HOME)/.Xdefaults
$(HOME)/.Xdefaults:
	@$(call cyan, "--\> Xdefaults")
	ln -s $(DOTDIR)/Xdefaults $(HOME)/.Xdefaults

.PHONY: sway-config
sway-config: \
    $(HOME)/.config/sway/config
$(HOME)/.config/sway/config:
	mkdir -p $(HOME)/.config/sway
	ln -s $(DOTDIR)/sway-config $(HOME)/.config/sway/config

.PHONY: wallpapers
wallpapers: \
    $(HOME)/.wallpapers/lavender.jpg \
    $(HOME)/.wallpapers/yosemite.jpg \
    $(HOME)/.wallpapers/elcapitan.jpg \
    $(HOME)/.wallpapers/sierra.jpg \
    $(HOME)/.wallpapers/highsierra.jpg \
    $(HOME)/.wallpapers/mojave-day.jpg \
    $(HOME)/.wallpapers/mojave-night.jpg \
    $(HOME)/.wallpapers/modis-cuba.jpg \
    $(HOME)/.wallpapers/UjK4eUF.jpg \
    $(HOME)/.wallpapers/ZZOuSd4.jpg \
    $(HOME)/.wallpapers/8YbJNGx.jpg \
    $(HOME)/.wallpapers/yf2IHMV.jpg \
    $(HOME)/.wallpapers/yDpuXU0.jpg \
    $(HOME)/.wallpapers/rnKPcCe.jpg \
    $(HOME)/.wallpapers/rain-night-girl.jpg
$(HOME)/.wallpapers/lavender.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://yese69.com/wp-content/uploads/data/2018/1/6/download-free-lavender-wallpape-WTG30615244.jpg -O $(HOME)/.wallpapers/lavender.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/yosemite.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget http://512pixels.net/downloads/macos-wallpapers/10-10.jpg -O $(HOME)/.wallpapers/yosemite.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/elcapitan.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget http://512pixels.net/downloads/macos-wallpapers/10-11.jpg -O $(HOME)/.wallpapers/elcapitan.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/sierra.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget http://512pixels.net/downloads/macos-wallpapers/10-12.jpg -O $(HOME)/.wallpapers/sierra.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/highsierra.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget http://512pixels.net/downloads/macos-wallpapers/10-13.jpg -O $(HOME)/.wallpapers/highsierra.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/mojave-day.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget http://512pixels.net/downloads/macos-wallpapers/10-14-Day.jpg -O $(HOME)/.wallpapers/mojave-day.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/mojave-night.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget http://512pixels.net/downloads/macos-wallpapers/10-14-Night.jpg -O $(HOME)/.wallpapers/mojave-night.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/modis-cuba.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://eoimages.gsfc.nasa.gov/images/imagerecords/64000/64374/Cuba.A2003021.1600.250m.jpg -O $(HOME)/.wallpapers/modis-cuba.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/UjK4eUF.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://i.imgur.com/UjK4eUF.jpg -O $(HOME)/.wallpapers/UjK4eUF.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/ZZOuSd4.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://i.imgur.com/ZZOuSd4.jpg -O $(HOME)/.wallpapers/ZZOuSd4.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/8YbJNGx.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://i.imgur.com/8YbJNGx.jpg -O $(HOME)/.wallpapers/8YbJNGx.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/yf2IHMV.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://i.imgur.com/yf2IHMV.jpg -O $(HOME)/.wallpapers/yf2IHMV.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/yDpuXU0.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://i.imgur.com/yDpuXU0.jpg -O $(HOME)/.wallpapers/yDpuXU0.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/rnKPcCe.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://i.imgur.com/rnKPcCe.jpg -O $(HOME)/.wallpapers/rnKPcCe.jpg > /dev/null 2>&1
$(HOME)/.wallpapers/rain-night-girl.jpg:
	mkdir -p $(HOME)/.wallpapers
	wget https://www.grayscale-wallpapers.com/grayscale/rain-night-manga-anime-girl-sad.jpg -O $(HOME)/.wallpapers/rain-night-girl.jpg > /dev/null 2>&1

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

.PHONY: hyper
hyper: $(HOME)/.hyper.js
$(HOME)/.hyper.js:
	ln -s $(DOTDIR)/hyper.js $(HOME)/.hyper.js
