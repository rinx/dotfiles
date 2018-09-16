.PHONY: \
    prepare-deploy \
    vim-deploy \
    vimrc \
    vimrc-private \
    vimshrc \
    dein-vim \
    neovim-deploy \
    init.vim \
    dein-nvim \
    git-deploy \
    gitconfig \
    gitconfig-local \
    gitignore \
    gitattributes \
    tmux-deploy \
    tmux.conf \
    zsh-deploy \
    zshrc \
    others-deploy \
    latexmkrc \
    Xdefaults \
    xmonad.hs \
    sway-config \
    wallpapers \
    i3status-config \
    lein-profile

prepare-deploy:
	@$(call cyan, "deploy stage")

vim-deploy: \
    vimrc \
    vimrc-private \
    vimshrc \
    vim-ftplugins \
    vim-ftdetects \
    vim-snippets \
    vim-indents \
    dein-vim
	@$(call red, "vim-deploy has been done")

vimrc: $(HOME)/.vimrc
$(HOME)/.vimrc:
	@$(call cyan, "--\> .vimrc")
	ln -s $(DOTDIR)/vimrc $(HOME)/.vimrc

vimrc-private: $(HOME)/.vimrc_private
$(HOME)/.vimrc_private:
	@$(call cyan, "--\> .vimrc_private")
	touch $(HOME)/.vimrc_private

vimshrc: $(HOME)/.vimshrc
$(HOME)/.vimshrc:
	@$(call cyan, "--\> .vimshrc")
	ln -s $(DOTDIR)/vimshrc $(HOME)/.vimshrc

dein-vim: $(HOME)/.vim/dein/repos/github.com/Shougo/dein.vim
$(HOME)/.vim/dein/repos/github.com/Shougo/dein.vim:
	@$(call cyan, "--\> dein.vim")
	mkdir -p $(HOME)/.vim/dein/repos/github.com/Shougo
	git clone https://github.com/Shougo/dein.vim $(HOME)/.vim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1

neovim-deploy: \
    init.vim \
    dein-nvim
	@$(call red, "neovim-deploy has been done")

init.vim: $(HOME)/.config/nvim/init.vim
$(HOME)/.config/nvim/init.vim:
	@$(call cyan, "--\> init.vim")
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/nvimrc $(HOME)/.config/nvim/init.vim


dein-nvim: $(HOME)/.config/nvim/dein/repos/github.com/Shougo/dein.vim
$(HOME)/.config/nvim/dein/repos/github.com/Shougo/dein.vim:
	@$(call cyan, "--\> dein.vim for nvim")
	mkdir -p $(HOME)/.config/nvim/dein/repos/github.com/Shougo
	git clone https://github.com/Shougo/dein.vim $(HOME)/.config/nvim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1

git-deploy: \
    gitconfig \
    gitconfig-local \
    gitignore \
    gitattributes
	@$(call red, "git-deploy")

gitconfig: $(HOME)/.gitconfig
$(HOME)/.gitconfig:
	@$(call cyan, "--\> gitconfig")
	ln -s $(DOTDIR)/gitconfig $(HOME)/.gitconfig

gitconfig-local: $(HOME)/.gitconfig.local
$(HOME)/.gitconfig.local:
	@$(call cyan, "--\> gitconfig.local")
	touch $(HOME)/.gitconfig.local

gitignore: $(HOME)/.gitignore
$(HOME)/.gitignore:
	@$(call cyan, "--\> gitignore")
	ln -s $(DOTDIR)/gitignore $(HOME)/.gitignore

gitattributes: $(HOME)/.gitattributes_global
$(HOME)/.gitattributes_global:
	@$(call cyan, "--\> gitattributes_global")
	ln -s $(DOTDIR)/gitattributes_global $(HOME)/.gitattributes_global

tmux-deploy: \
    tmux.conf \
    tpm
	@$(call red, "tmux-deploy has been done")

tmux.conf: $(HOME)/.tmux.conf
$(HOME)/.tmux.conf:
	@$(call cyan, "--\> tmux.conf")
	ln -s $(DOTDIR)/tmux.conf $(HOME)/.tmux.conf

tpm: $(HOME)/.tmux/plugins/tpm
$(HOME)/.tmux/plugins/tpm:
	mkdir -p $(HOME)/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm

zsh-deploy: \
    zshrc
	@$(call red, "zsh-deploy has been done")

zshrc: $(HOME)/.zshrc
$(HOME)/.zshrc:
	@$(call cyan, "--\> zshrc")
	ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

others-deploy: \
    latexmkrc \
    Xdefaults \
    xmonad.hs \
    sway-config \
    i3status-config \
    lein-profile
	@$(call red, "others-deploy")

latexmkrc: $(HOME)/.latexmkrc
$(HOME)/.latexmkrc:
	@$(call cyan, "--\> latexmkrc")
	ln -s $(DOTDIR)/latexmkrc $(HOME)/.latexmkrc

Xdefaults: $(HOME)/.Xdefaults
$(HOME)/.Xdefaults:
	@$(call cyan, "--\> Xdefaults")
	ln -s $(DOTDIR)/Xdefaults $(HOME)/.Xdefaults

xmonad.hs: $(HOME)/.xmonad/xmonad.hs
$(HOME)/.xmonad/xmonad.hs:
	mkdir -p $(HOME)/.xmonad
	ln -s $(DOTDIR)/xmonad.hs $(HOME)/.xmonad/xmonad.hs

sway-config: \
    $(HOME)/.config/sway/config \
    wallpapers
$(HOME)/.config/sway/config:
	mkdir -p $(HOME)/.config/sway
	ln -s $(DOTDIR)/sway-config $(HOME)/.config/sway/config

wallpapers: \
    $(HOME)/.wallpapers/lavender.jpg \
    $(HOME)/.wallpapers/yosemite.jpg \
    $(HOME)/.wallpapers/elcapitan.jpg \
    $(HOME)/.wallpapers/sierra.jpg \
    $(HOME)/.wallpapers/highsierra.jpg \
    $(HOME)/.wallpapers/mojave-day.jpg \
    $(HOME)/.wallpapers/mojave-night.jpg \
    $(HOME)/.wallpapers/modis-cuba.jpg
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

i3status-config: \
    $(HOME)/.config/i3status/config
$(HOME)/.config/i3status/config:
	mkdir -p $(HOME)/.config/i3status
	ln -s $(DOTDIR)/i3status-config $(HOME)/.config/i3status/config

lein-profile: $(HOME)/.lein/profiles.clj
$(HOME)/.lein/profiles.clj:
	mkdir -p $(HOME)/.lein
	ln -s $(DOTDIR)/profiles.clj $(HOME)/.lein/profiles.clj

