.PHONY: \
    prepare-deploy \
    vim-deploy \
    vimrc \
    vimshrc \
    dein-vim \
    neovim-deploy \
    init.vim \
    dein-nvim \
    git-deploy \
    gitconfig \
    gitignore \
    gitattributes \
    tmux-deploy \
    tmux.conf \
    zsh-deploy \
    zshrc \
    others-deploy \
    latexmkrc \
    Xdefaults

prepare-deploy:
	@$(call cyan, "deploy stage")

vim-deploy: \
    vimrc \
    vimshrc \
    dein-vim
	@$(call red, "vim-deploy has been done")

vimrc: $(HOME)/.vimrc
$(HOME)/.vimrc:
	@$(call cyan, "--\> .vimrc")
	ln -s $(DOTDIR)/vimrc $(HOME)/.vimrc

vimshrc: $(HOME)/.vimshrc
$(HOME)/.vimshrc:
	@$(call cyan, "--\> .vimshrc")
	ln -s $(DOTDIR)/vimshrc $(HOME)/.vimshrc

dein-vim: $(HOME)/.vim/dein/repos/github.com/Shougo/dein.vim
$(HOME)/.vim/dein/repos/github.com/Shougo/dein.vim:
	@$(call cyan, "--\> dein.vim")
	mkdir -p $HOME/.vim/dein/repos/github.com/Shougo
	git clone https://github.com/Shougo/dein.vim $HOME/.vim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1

neovim-deploy: \
    init.vim \
    dein-nvim
	@$(call red, "neovim-deploy has been done")

init.vim: $(HOME)/.config/nvim/init.vim
$(HOME)/.config/nvim/init.vim:
	@$(call cyan, "--\> init.vim")
	mkdir -p $HOME/.config/nvim
	ln -s $DOTDIR/nvimrc $HOME/.config/nvim/init.vim


dein-nvim: $(HOME)/.config/nvim/dein/repos/github.com/Shougo/dein.vim
$(HOME)/.config/nvim/dein/repos/github.com/Shougo/dein.vim:
	@$(call cyan, "--\> dein.vim for nvim")
	mkdir -p $HOME/.config/nvim/dein/repos/github.com/Shougo
	git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1

git-deploy: \
    gitconfig \
    gitignore \
    gitattributes
	@$(call red, "git-deploy")

gitconfig: $(HOME)/.gitconfig
$(HOME)/.gitconfig:
	@$(call cyan, "--\> gitconfig")
	ln -s $(DOTDIR)/gitconfig $(HOME)/.gitconfig

gitignore: $(HOME)/.gitignore
$(HOME)/.gitignore:
	@$(call cyan, "--\> gitignore")
	ln -s $(DOTDIR)/gitignore $(HOME)/.gitignore

gitattributes: $(HOME)/.gitattributes_global
$(HOME)/.gitattributes_global:
	@$(call cyan, "--\> gitattributes_global")
	ln -s $(DOTDIR)/gitattributes_global $(HOME)/.gitattributes_global

tmux-deploy: \
    tmux.conf
	@$(call red, "tmux-deploy has been done")

tmux.conf: $(HOME)/.tmux.conf
$(HOME)/.tmux.conf:
	@$(call cyan, "--\> tmux.conf")
	ln -s $(DOTDIR)/tmux.conf $(HOME)/.tmux.conf

zsh-deploy: \
    zshrc
	@$(call red, "zsh-deploy has been done")

zshrc: $(HOME)/.zshrc
$(HOME)/.zshrc:
	@$(call cyan, "--\> zshrc")
	ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

others-deploy: \
    latexmkrc \
    Xdefaults
	@$(call red, "others-deploy")

latexmkrc: $(HOME)/.latexmkrc
$(HOME)/.latexmkrc:
	@$(call cyan, "--\> latexmkrc")
	ln -s $(DOTDIR)/latexmkrc $(HOME)/.latexmkrc

Xdefaults: $(HOME)/.Xdefaults
$(HOME)/.Xdefaults:
	@$(call cyan, "--\> Xdefaults")
	ln -s $(DOTDIR)/Xdefaults $(HOME)/.Xdefaults

