#!/bin/sh

#this script makes symbolic links of vimrc, zshrc

if [ ! -f $HOME/.vimrc ]; then
    ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.vimrc created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/.vimrc creating failed\033[00m" | sed "s/^-e //"
    fi
fi

if [ ! -f $HOME/.zshrc ]; then
    ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.zshrc created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/.zshrc creating failed\033[00m" | sed "s/^-e //"
    fi
fi

if [ ! -f $HOME/.tmux.conf ]; then
    ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.tmux.conf created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/.tmux.conf creating failed\033[00m" | sed "s/^-e //"
    fi
fi

if [ ! -f $HOME/.gitconfig ]; then
    ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.gitconfig created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/.gitconfig creating failed\033[00m" | sed "s/^-e //"
    fi
fi

if [ ! -f $HOME/.gitignore ]; then
    ln -s $HOME/.dotfiles/.gitignore $HOME/.gitignore
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.gitignore created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/.gitignore creating failed\033[00m" | sed "s/^-e //"
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
wget -qO- https://gist.github.com/rinx/8645095/raw/657292120e52514f05efa3684846c8d2808478be/vim-ft-setup.sh | sh
