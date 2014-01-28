#!/bin/sh

#this script makes symbolic links of vimrc, zshrc, etc...

if [ ! -f $HOME/.vimrc ]; then
    ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
    echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.vimrc created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.zshrc ]; then
    ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
    echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.zshrc created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.tmux.conf ]; then
    ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
    echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.tmux.conf created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.xmonad/xmonad.hs ]; then
    mkdir -p $HOME/.xmonad
    ln -s $HOME/.dotfiles/xmonad.hs $HOME/.xmonad/xmonad.hs
    echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.xmonad/xmonad.hs created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.gitconfig ]; then
    ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
    echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.gitconfig created\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.gitignore ]; then
    ln -s $HOME/.dotfiles/.gitignore $HOME/.gitignore
    echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.gitignore created\033[00m" | sed "s/^-e //"
fi

#for tmux statusline memory-status
if [ ! -x $HOME/.bin/used-mem ]; then
    wget https://raw.github.com/yonchu/used-mem/master/used-mem -P $HOME/.bin > /dev/null 2>&1
    chmod +x $HOME/.bin/used-mem
    echo -e "\033[0;32m✔ \033[1;36mA executable file 'used-mem' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
fi

#for tmux statusline battery-status
if [ ! -x $HOME/.bin/battery ]; then
    wget https://raw.github.com/richo/battery/master/bin/battery -P $HOME/.bin > /dev/null 2>&1
    chmod +x $HOME/.bin/battery
    echo -e "\033[0;32m✔ \033[1;36mA executable file 'battery' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
fi


# for vim 
if [ ! -d $HOME/.vim/bundle/neobundle.vim ]; then
    mkdir -p $HOME/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
fi

# vim filetype plugins
wget -qO- https://gist.github.com/rinx/8645095/raw/1e47048a982824ca12f0a4e6616e8e906e3b2561/vim-ft-setup.sh | sh

