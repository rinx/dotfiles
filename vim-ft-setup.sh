#!/bin/sh

CMDNAME=`basename $0`
DOTDIR=$(cd $(dirname $0); pwd)

while getopts cf OPT
do
    case $OPT in
        "c" ) FLG_C="TRUE" ;;
        "f" ) FLG_F="TRUE" ;;
          * ) echo "Usage: $CMDNAME [-c] [-f]" 1>&2 
              exit 1 ;;
    esac
done

mkdir -p $HOME/.vim/ftplugin

for scriptname in fortran/fortran.vim python/python.vim ruby/ruby.vim tex/tex.vim idlang/idlang.vim
do
    if [ ! -f $HOME/.vim/ftplugin/${scriptname} ] || [ "$FLG_F" = "TRUE" ]; then
        scriptdir=`echo ${scriptname} | sed -e 's/\/.*\.vim//'`
        mkdir -p $HOME/.vim/ftplugin/${scriptdir}
        [ "$FLG_F" = "TRUE" ] && rm -f $HOME/.vim/ftplugin/${scriptname}
        ln -s $DOTDIR/dotvim/ftplugin/${scriptname} $HOME/.vim/ftplugin/${scriptname}
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;35mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/${scriptname} created\033[00m" | sed "s/^-e //"
        else
            echo -e "\033[0;31m✗ \033[1;31mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/${scriptname} creating failed\033[00m" | sed "s/^-e //"
        fi
    fi
done

mkdir -p $HOME/.vim/ftdetect
for scriptname in markdown.vim
do
    if [ ! -f $HOME/.vim/ftdetect/${scriptname} ] || [ "$FLG_F" = "TRUE" ]; then
        [ "$FLG_F" = "TRUE" ] && rm -f $HOME/.vim/ftdetect/${scriptname}
        ln -s $DOTDIR/dotvim/ftdetect/${scriptname} $HOME/.vim/ftdetect/${scriptname}
        if [ $? -eq 0 ]; then
            echo -e "\033[0;32m✔ \033[1;35mA symbolic link of Vim filetype plugin $HOME/.vim/ftdetect/${scriptname} created\033[00m" | sed "s/^-e //"
        else
            echo -e "\033[0;31m✗ \033[1;31mA symbolic link of Vim filetype plugin $HOME/.vim/ftdetect/${scriptname} creating failed\033[00m" | sed "s/^-e //"
        fi
    fi
done

if [ ! -f $HOME/.vim/filetype.vim ] || [ "$FLG_F" = "TRUE" ]; then
    [ "$FLG_F" = "TRUE" ] && rm -f $HOME/.vim/filetype.vim
    ln -s $DOTDIR/dotvim/filetype.vim $HOME/.vim/filetype.vim
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link of Vim filetype plugin $HOME/.vim/filetype.vim created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link of Vim filetype plugin $HOME/.vim/filetype.vim creating failed\033[00m" | sed "s/^-e //"
    fi
fi

mkdir -p $HOME/.vim/syntax
wget -N 'https://raw.githubusercontent.com/tmux/tmux/master/examples/tmux.vim' -O $HOME/.vim/syntax/tmux.vim > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "\033[0;32m✔ \033[1;35mA Vim syntax plugin $HOME/.vim/syntax/tmux.vim downloaded\033[00m" | sed "s/^-e //"
else
    echo -e "\033[0;31m✗ \033[1;31mA Vim syntax plugin $HOME/.vim/syntax/tmux.vim downloading failed\033[00m" | sed "s/^-e //"
fi


if [ ! -d $HOME/.vim/my-snippets ] || [ "$FLG_F" = "TRUE" ]; then
    [ "$FLG_F" = "TRUE" ] && rm -rf $HOME/.vim/my-snippets
    ln -s $DOTDIR/dotvim/my-snippets $HOME/.vim/my-snippets
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link of directory $HOME/.vim/my-snippets created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link of directory $HOME/.vim/my-snippets creating failed\033[00m" | sed "s/^-e //"
    fi
fi

if [ ! -d $HOME/.vim/indent ] || [ "$FLG_F" = "TRUE" ]; then
    [ "$FLG_F" = "TRUE" ] && rm -rf $HOME/.vim/indent
    ln -s $DOTDIR/dotvim/indent $HOME/.vim/indent
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link of directory $HOME/.vim/indent created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link of directory $HOME/.vim/indent creating failed\033[00m" | sed "s/^-e //"
    fi
fi

