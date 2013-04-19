#!/bin/sh

#this script makes symbolic links of vimrc, zshrc

ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.gitignore ~/.gitignore


#for tmux statusline battery-status
wget https://raw.github.com/richo/battery/master/bin/battery -P ~/.bin
chmod +x ~/.bin/battery

