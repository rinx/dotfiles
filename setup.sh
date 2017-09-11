#!/bin/sh

CMDNAME=`basename $0`
DOTDIR=$(cd $(dirname $0); pwd)

while getopts acfstv OPT
do
    case $OPT in
        "a" ) FLG_A="TRUE" ;;
        "c" ) FLG_C="TRUE" ;;
        "f" ) FLG_F="TRUE" ;;
        "s" ) FLG_S="TRUE" ;;
        "t" ) FLG_T="TRUE" ;;
        "v" ) FLG_V="TRUE" ;;
          * ) echo "Usage: $CMDNAME [-c] [-f] [-astv]" 1>&2 
              exit 1 ;;
    esac
done

if [ "$FLG_A" = "TRUE" ]; then
    FLG_S="TRUE"
    FLG_T="TRUE"
    FLG_V="TRUE"
fi

#this script makes symbolic links of vimrc, zshrc

if [ "$FLG_S" = "TRUE" ]; then
    for filename in vimrc zshrc tmux.conf gitconfig gitignore gitattributes_global latexmkrc vimshrc; do
        if [ ! -f $HOME/.$filename ] || [ "$FLG_F" = "TRUE" ]; then
            [ "$FLG_F" = "TRUE" ] && [ -f $HOME/.$filename ] && rm -f $HOME/.$filename
            ln -s $DOTDIR/$filename $HOME/.$filename
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
fi

if [ "$FLG_T" = "TRUE" ]; then
    if [ ! -d $HOME/.bin ]; then
        mkdir $HOME/.bin
    fi

    #for tmux statusline local-ipaddress
    if [ ! -x $HOME/.bin/getipaddr ] || [ "$FLG_F" = "TRUE" ]; then
        wget https://gist.github.com/raw/9885825/getipaddr -O $HOME/.bin/getipaddr > /dev/null 2>&1
        chmod +x $HOME/.bin/getipaddr
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;36mA executable file 'getipaddr' downloaded in $HOME/.bin\033[00m" | sed "s/^-e //"
        else
            echo -e "\033[0;31m✗ \033[1;31mA executable file 'getipaddr' downloading failed\033[00m" | sed "s/^-e //"
        fi
    elif [ "$FLG_C" = "TRUE" ]; then
        [ -f $HOME/.bin/getipaddr ] && rm -f $HOME/.bin/getipaddr
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;36mA executable file $HOME/.bin/getipaddr removed\033[00m" | sed "s/^-e //"
        fi
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.bin/getipaddr \033[00m" | sed "s/^-e //"
    fi

    #tmux-plugin manager
    if [ ! -d $HOME/.tmux/plugins ] || [ "$FLG_F" = "TRUE" ]; then
        mkdir -p $HOME/.tmux/plugins
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.tmux/plugins \033[00m" | sed "s/^-e //"
    fi
fi

if [ "$FLG_V" = "TRUE" ]; then
    # for vim 
    if [ ! -d $HOME/.vim/dein/repos/github.com/Shougo/dein.vim ] || [ "$FLG_F" = "TRUE" ]; then
        [ "$FLG_F" = "TRUE" ] && [ -d $HOME/.vim/repos/github.com/Shougo/dein/dein.vim ] && rm -rf $HOME/.vim/dein/repos/github.com/Shougo/dein.vim
        mkdir -p $HOME/.vim/dein/repos/github.com/Shougo
        git clone https://github.com/Shougo/dein.vim $HOME/.vim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;36mdein.vim cloned in $HOME/.vim/deinrepos/github.com/Shougo/dein.vim\033[00m" | sed "s/^-e //"

            # install plugins using dein.vim
            vim -N -u NONE -i NONE -V1 -e -s --cmd "source $DOTDIR/vimrc" --cmd 'call dein#install()' --cmd quit
            if [ $? -eq 0 ]; then
                echo -e "\033[0;32m✔ \033[1;36minstall plugins using dein.vim successed\033[00m" | sed "s/^-e //"
            else
                echo -e "\033[0;31m✗ \033[1;31minstall plugins using dein.vim failed\033[00m" | sed "s/^-e //"
            fi

        else
            echo -e "\033[0;31m✗ \033[1;31mdein.vim cloning failed\033[00m" | sed "s/^-e //"
        fi
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.vim/dein/repos/github.com/Shougo/dein.vim \033[00m" | sed "s/^-e //"
    fi

    # neovim
    if [ ! -d $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim ] || [ "$FLG_F" = "TRUE" ]; then
        [ "$FLG_F" = "TRUE" ] && [ -d $HOME/.config/nvim/repos/github.com/Shougo/dein/dein.vim ] && rm -rf $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
        mkdir -p $HOME/.config/nvim/dein/repos/github.com/Shougo
        git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;36mdein.vim cloned in $HOME/.config/nvim/deinrepos/github.com/Shougo/dein.vim\033[00m" | sed "s/^-e //"

            # install plugins using dein.vim
            nvim -N -u NONE -i NONE -V1 -e -s --cmd "source $DOTDIR/vimrc" --cmd 'call dein#install()' --cmd quit
            if [ $? -eq 0 ]; then
                echo -e "\033[0;32m✔ \033[1;36minstall plugins using dein.vim successed\033[00m" | sed "s/^-e //"
            else
                echo -e "\033[0;31m✗ \033[1;31minstall plugins using dein.vim failed\033[00m" | sed "s/^-e //"
            fi

        else
            echo -e "\033[0;31m✗ \033[1;31mdein.vim cloning failed\033[00m" | sed "s/^-e //"
        fi
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim \033[00m" | sed "s/^-e //"
    fi


    if [ ! -f $HOME/.config/nvim/init.vim ] || [ "$FLG_F" = "TRUE" ]; then
        mkdir -p $HOME/.config/nvim
        ln -s $DOTDIR/nvimrc $HOME/.config/nvim/init.vim
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;36mA symbolic link $HOME/.config/nvim/init.vim created\033[00m" | sed "s/^-e //"
        else
            echo -e "\033[0;31m✗ \033[1;31mA symbolic link from $HOME/.config/nvim/init.vim creating failed\033[00m" | sed "s/^-e //"
        fi
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.config/nvim/init.vim \033[00m" | sed "s/^-e //"
    fi

    # vim filetype plugins
    if [ "$FLG_F" = "TRUE" ]; then
        sh $DOTDIR/vim-ft-setup.sh -f
    else
        sh $DOTDIR/vim-ft-setup.sh
    fi

fi

