#!/bin/sh

CMDNAME=`basename $0`

while getopts cf OPT
do
    case $OPT in
        "c" ) FLG_C="TRUE" ;;
        "f" ) FLG_F="TRUE" ;;
          * ) echo "Usage: $CMDNAME [-c means 'clean'] [-f means 'force']" 1>&2 
              exit 1 ;;
    esac
done

#this script makes symbolic links of vimrc, zshrc

for filename in vimrc zshrc tmux.conf gitconfig gitignore ; do
    
    if [ ! -f $HOME/.$filename ] || [ "$FLG_F" = "TRUE" ]; then
        [ "$FLG_F" = "TRUE" ] && [ -f $HOME/.$filename ] && rm -f $HOME/.$filename
        ln -s $HOME/.dotfiles/$filename $HOME/.$filename
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;35mA symbolic link $HOME/.$filename created\033[00m" | sed "s/^-e //"
        else
            echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/.$filename creating failed\033[00m" | sed "s/^-e //"
        fi
    elif [ "$FLG_C" = "TRUE" ]; then
        [ -f $HOME/.$filename ] && rm -f $HOME/.$filename
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;36mA symbolic link $HOME/.$filename removed\033[00m" | sed "s/^-e //"
        fi
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.$filename file.\033[00m" | sed "s/^-e //"
    fi
    
done

#for tmux statusline memory-status
if [ ! -x $HOME/.bin/used-mem ] || [ "$FLG_F" = "TRUE" ]; then
    wget https://raw.github.com/yonchu/used-mem/master/used-mem -O $HOME/.bin/used-mem > /dev/null 2>&1
    chmod +x $HOME/.bin/used-mem
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;36mA executable file 'used-mem' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA executable file 'used-mem' downloading failed\033[00m" | sed "s/^-e //"       
    fi
elif [ "$FLG_C" = "TRUE" ]; then
    [ -f $HOME/.bin/used-mem ] && rm -f $HOME/.bin/used-mem
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;36mA executable file $HOME/.bin/used-mem removed\033[00m" | sed "s/^-e //"
    fi
fi

#for tmux statusline battery-status
if [ ! -x $HOME/.bin/battery ] || [ "$FLG_F" = "TRUE" ]; then
    wget https://raw.github.com/richo/battery/master/bin/battery -O $HOME/.bin/battery > /dev/null 2>&1
    chmod +x $HOME/.bin/battery
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;36mA executable file 'battery' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA executable file 'battery' downloading failed\033[00m" | sed "s/^-e //"
    fi
elif [ "$FLG_C" = "TRUE" ]; then
    [ -f $HOME/.bin/battery ] && rm -f $HOME/.bin/battery
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;36mA executable file $HOME/.bin/battery removed\033[00m" | sed "s/^-e //"
    fi
fi


# for vim 
if [ ! -d $HOME/.vim/bundle/neobundle.vim ] || [ "$FLG_F" = "TRUE" ]; then
    [ "$FLG_F" = "TRUE" ] && [ -d $HOME/.vim/bundle/neobundle.vim ] && rm -rf $HOME/.vim/bundle/neobundle.vim
    mkdir -p $HOME/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;36mneobundle.vim cloned in $HOME/.vim/bundle/neobundle.vim\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mneobundle.vim cloning failed\033[00m" | sed "s/^-e //"
    fi
fi

# vim filetype plugins
[ "$FLG_C" = "TRUE" ] || wget -qO- https://gist.github.com/raw/8645095/vim-ft-setup.sh | sh
