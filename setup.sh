#!/bin/sh

#this script makes symbolic links of vimrc, zshrc

if [ ! -f $HOME/.vimrc ]; then
    ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
    echo -e "\033[1;35mA symbolic link $HOME/.vimrc created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.zshrc ]; then
    ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
    echo -e "\033[1;35mA symbolic link $HOME/.zshrc created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.tmux.conf ]; then
    ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
    echo -e "\033[1;35mA symbolic link $HOME/.tmux.conf created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.gitconfig ]; then
    ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
    echo -e "\033[1;35mA symbolic link $HOME/.gitconfig created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.gitignore ]; then
    ln -s $HOME/.dotfiles/.gitignore $HOME/.gitignore
    echo -e "\033[1;35mA symbolic link $HOME/.gitignore created\033[00m" | sed "s/^-e //"
fi

#for tmux statusline memory-status
if [ ! -x $HOME/.bin/used-mem ]; then
    wget https://raw.github.com/yonchu/used-mem/master/used-mem -P $HOME/.bin > /dev/null 2>&1
    chmod +x $HOME/.bin/used-mem
    echo -e "\033[1;36mA executable file 'used-mem' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
fi

#for tmux statusline battery-status
if [ ! -x $HOME/.bin/battery ]; then
    wget https://raw.github.com/richo/battery/master/bin/battery -P $HOME/.bin > /dev/null 2>&1
    chmod +x $HOME/.bin/battery
    echo -e "\033[1;36mA executable file 'battery' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
fi

