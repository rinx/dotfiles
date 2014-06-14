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

if [ ! -f $HOME/.vim/ftplugin/fortran/fortran.vim ] || [ "$FLG_F" = "TRUE" ]; then
    mkdir -p $HOME/.vim/ftplugin/fortran
    [ "$FLG_F" = "TRUE" ] && rm -f $HOME/.vim/ftplugin/fortran/fortran.vim
    ln -s $DOTDIR/dotvim/ftplugin/fortran/fortran.vim $HOME/.vim/ftplugin/fortran/fortran.vim
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/fortran/fortran.vim created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/fortran/fortran.vim creating failed\033[00m" | sed "s/^-e //"
    fi
fi

if [ ! -f $HOME/.vim/ftplugin/python/python.vim ] || [ "$FLG_F" = "TRUE" ]; then
    mkdir -p $HOME/.vim/ftplugin/python
    [ "$FLG_F" = "TRUE" ] && rm -f $HOME/.vim/ftplugin/python/python.vim
    ln -s $DOTDIR/dotvim/ftplugin/python/python.vim $HOME/.vim/ftplugin/python/python.vim
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/python/python.vim created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/python/python.vim creating failed\033[00m" | sed "s/^-e //"
    fi
fi

if [ ! -f $HOME/.vim/ftplugin/ruby/ruby.vim ] || [ "$FLG_F" = "TRUE" ]; then
    mkdir -p $HOME/.vim/ftplugin/ruby
    [ "$FLG_F" = "TRUE" ] && rm -f $HOME/.vim/ftplugin/ruby/ruby.vim
    ln -s $DOTDIR/dotvim/ftplugin/ruby/ruby.vim $HOME/.vim/ftplugin/ruby/ruby.vim
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/ruby/ruby.vim created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/ruby/ruby.vim creating failed\033[00m" | sed "s/^-e //"
    fi
fi

if [ ! -f $HOME/.vim/ftplugin/tex/tex.vim ] || [ "$FLG_F" = "TRUE" ]; then
    mkdir -p $HOME/.vim/ftplugin/tex
    [ "$FLG_F" = "TRUE" ] && rm -f $HOME/.vim/ftplugin/tex/tex.vim
    ln -s $DOTDIR/dotvim/ftplugin/tex/tex.vim $HOME/.vim/ftplugin/tex/tex.vim
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/tex/tex.vim created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link of Vim filetype plugin $HOME/.vim/ftplugin/tex/tex.vim creating failed\033[00m" | sed "s/^-e //"
    fi
fi

mkdir -p $HOME/.vim/ftdetect
if [ ! -f $HOME/.vim/ftdetect/markdown.vim ] || [ "$FLG_F" = "TRUE" ]; then
    [ "$FLG_F" = "TRUE" ] && rm -f $HOME/.vim/ftdetect/markdown.vim
    ln -s $DOTDIR/dotvim/ftdetect/markdown.vim $HOME/.vim/ftdetect/markdown.vim
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m✔ \033[1;35mA symbolic link of Vim filetype plugin $HOME/.vim/ftdetect/markdown.vim created\033[00m" | sed "s/^-e //"
    else
        echo -e "\033[0;31m✗ \033[1;31mA symbolic link of Vim filetype plugin $HOME/.vim/ftdetect/markdown.vim creating failed\033[00m" | sed "s/^-e //"
    fi
fi

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
wget -N 'http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/examples/tmux.vim?format=raw' -O $HOME/.vim/syntax/tmux.vim > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "\033[0;32m✔ \033[1;35mA Vim syntax plugin $HOME/.vim/syntax/tmux.vim downloaded\033[00m" | sed "s/^-e //"
else
    echo -e "\033[0;31m✗ \033[1;31mA Vim syntax plugin $HOME/.vim/syntax/tmux.vim downloading failed\033[00m" | sed "s/^-e //"
fi

