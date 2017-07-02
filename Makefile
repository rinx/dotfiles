# this Makefile is just a draft!!
DOTDIR := ~/.dotfiles
DOTFILES := vimrc zshrc tmux.conf gitconfig gitignore gitattributes_global latexmkrc vimshrc


all: deploy


deploy: # make symbolic links to the dotfiles
	sh setup.sh -af


init: # initialize all configures


test:


check-commands: # check whether required commands are installed


clean:


# deploy

vim-deploy:


git-deploy:


tmux-deploy:


zsh-deploy:


others-deploy:


# init

vim-init:


tmux-init:



