#!/bin/sh

#this script makes symbolic links of vimrc, zshrc, etc...

[ -f ~/.vimrc     ] || ln -s ~/.dotfiles/.vimrc     ~/.vimrc
[ -f ~/.zshrc     ] || ln -s ~/.dotfiles/.zshrc     ~/.zshrc
[ -f ~/.tmux.conf ] || ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

[ -f ~/.gitconfig ] || ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
[ -f ~/.gitignore ] || ln -s ~/.dotfiles/.gitignore ~/.gitignore

[ -f ~/.xmonad/xmonad.hs ] || ln -s ~/.dotfiles/xmonad.hs ~/.xmonad/xmonad.hs


#for tmux statusline memory-status
if [ ! -x ~/.bin/used-mem ]; then
    wget https://raw.github.com/yonchu/used-mem/master/used-mem -P ~/.bin
    chmod +x ~/.bin/used-mem
fi

#for tmux statusline battery-status
if [ ! -x ~/.bin/battery ]; then
    wget https://raw.github.com/richo/battery/master/bin/battery -P ~/.bin
    chmod +x ~/.bin/battery
fi

