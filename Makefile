# this Makefile is just a draft!!
DOTDIR := \
    ~/.dotfiles
DOTFILES := \
    vimrc \
    zshrc \
    tmux.conf \
    gitconfig \
    gitignore \
    gitattributes_global \
    latexmkrc \
    vimshrc


all: \
    deploy \
    init

# make symbolic links to the dotfiles
deploy: \
    vim-deploy \
    git-deploy \
    tmux-deploy \
    zsh-deploy \
    others-deploy
	echo "** deploy **"
	echo "==="
	# sh setup.sh -af


# initialize all configures
init: \
    vim-init \
    tmux-init
	echo "** initialize **"
	echo "==="


test:
	echo "** test **"
	echo "==="


# check whether required commands are installed
check-commands:
	echo "** check-commands **"
	echo "==="


clean:
	echo "** clean **"
	echo "==="
	# sh setup.sh -ac

# deploy

vim-deploy:
	echo "vim-deploy"
	echo "==="
	# ln -s $(DOTDIR)/vimrc $(HOME)/.vimrc
	# ln -s $(DOTDIR)/vimshrc $(HOME)/.vimshrc
	echo "install dein for Vim"
	echo "---"


git-deploy:
	echo "git-deploy"
	echo "==="
	# ln -s $(DOTDIR)/gitconfig $(HOME)/.gitconfig
	# ln -s $(DOTDIR)/gitignore $(HOME)/.gitignore
	# ln -s $(DOTDIR)/gitattributes_global $(HOME)/.gitattributes_global

tmux-deploy:
	echo "tmux-deploy"
	echo "==="
	# ln -s $(DOTDIR)/tmux.conf $(HOME)/.tmux.conf
	echo "tmux plugin manager"
	echo "---"
	echo "getipaddr binary"
	echo "---"

zsh-deploy:
	echo "zsh-deploy"
	echo "==="
	# ln -s $(DOTDIR)/zshrc $(HOME)/.zshrc

others-deploy:
	echo "others-deploy"
	echo "==="
	# ln -s $(DOTDIR)/latexmkrc $(HOME)/.latexmkrc

# init

vim-init:
	echo "vim-init"
	echo "==="
	echo "initialize dein for Vim"
	echo "---"


tmux-init:
	echo "tmux-init"
	echo "==="
	# git submodule update --init


