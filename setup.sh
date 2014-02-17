#!/bin/sh

#this script makes symbolic links of vimrc, zshrc, etc...

for filename in .vimrc .zshrc .tmux.conf .gitconfig .gitignore ; do
    
    if [ ! -f $HOME/$filename ]; then
        ln -s $HOME/.dotfiles/$filename $HOME/$filename
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/$filename created\033[00m" | sed "s/^-e //"
        else
            echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/$filename creating failed\033[00m" | sed "s/^-e //"
        fi
    fi
    
done

if [ ! -f $HOME/.xmonad/xmonad.hs ]; then
    mkdir -p $HOME/.xmonad
    ln -s $HOME/.dotfiles/xmonad.hs $HOME/.xmonad/xmonad.hs
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.xmonad/xmonad.hs created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/.xmonad/xmonad.hs creating failed\033[00m" | sed "s/^-e //"
    fi
fi

#for tmux statusline memory-status
if [ ! -x $HOME/.bin/used-mem ]; then
    wget https://raw.github.com/yonchu/used-mem/master/used-mem -P $HOME/.bin > /dev/null 2>&1
    chmod +x $HOME/.bin/used-mem
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;36mA executable file 'used-mem' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA executable file 'used-mem' downloading failed\033[00m" | sed "s/^-e //"       
    fi
fi

#for tmux statusline battery-status
if [ ! -x $HOME/.bin/battery ]; then
    wget https://raw.github.com/richo/battery/master/bin/battery -P $HOME/.bin > /dev/null 2>&1
    chmod +x $HOME/.bin/battery
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;36mA executable file 'battery' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA executable file 'battery' downloading failed\033[00m" | sed "s/^-e //"
    fi
fi


# for vim 
if [ ! -d $HOME/.vim/bundle/neobundle.vim ]; then
    mkdir -p $HOME/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;36mneobundle.vim cloned in $HOME/.vim/bundle/neobundle.vim\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mneobundle.vim cloning failed\033[00m" | sed "s/^-e //"
    fi
fi

# vim filetype plugins
wget -qO- https://gist.github.com/rinx/8645095/raw/8bb6b289b202950f97503995747a2a755c64c7ca/vim-ft-setup.sh | sh
