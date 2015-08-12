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
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.bin/used-mem\033[00m" | sed "s/^-e //"
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
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.bin/battery\033[00m" | sed "s/^-e //"
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
    if [ ! -d $HOME/.tmux ] || [ "$FLG_F" = "TRUE" ]; then
        mkdir -p $HOME/.tmux
        ln -s $DOTDIR/dottmux/plugins $HOME/.tmux/plugins
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;36mA symbolic link $HOME/.tmux/plugins created\033[00m" | sed "s/^-e //"
        else
            echo -e "\033[0;31m✗ \033[1;31mA symbolic link $HOME/.tmux/plugins creating failed\033[00m" | sed "s/^-e //"
        fi
    elif [ "$FLG_C" = "TRUE" ]; then
        [ -f $HOME/.bin/getipaddr ] && rm -f $HOME/.bin/getipaddr
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;36mA symbolic link $HOME/.tmux removed\033[00m" | sed "s/^-e //"
        fi
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.tmux \033[00m" | sed "s/^-e //"
    fi
fi

if [ "$FLG_V" = "TRUE" ]; then
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
    else
        echo -e "\033[0;31m✗ \033[1;31mThere's already $HOME/.vim/bundle/neobundle.vim \033[00m" | sed "s/^-e //"
    fi

    # vim filetype plugins
    if [ "$FLG_F" = "TRUE" ]; then
        sh $DOTDIR/vim-ft-setup.sh -f
    else
        sh $DOTDIR/vim-ft-setup.sh
    fi

fi

