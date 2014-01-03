#!/bin/sh

# this script makes ~/.vim/ftplugin/*


if [ ! -f $HOME/.vim/ftplugin/python/python.vim ]; then
    wget https://gist.github.com/rinx/5018808/raw/15b8d29a4abf42bef2a2ee35a46243796e5eedec/python.vim -P $HOME/.vim/ftplugin/python > /dev/null 2>&1
    echo -e "\033[0;32m✔ \033[1;36mA ftplugin 'python.vim' downloaded in $HOME/.vim/ftplugin/python\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.vim/ftplugin/ruby/ruby.vim ]; then
    wget https://gist.github.com/rinx/5018810/raw/5f7684b92ab88b97f545b5eb14e256634f99d805/ruby.vim -P $HOME/.vim/ftplugin/ruby > /dev/null 2>&1
    echo -e "\033[0;32m✔ \033[1;36mA ftplugin 'ruby.vim' downloaded in $HOME/.vim/ftplugin/ruby\033[00m" | sed "s/^-e //"
fi

if [ ! -f $HOME/.vim/ftplugin/tex/tex.vim ]; then
    wget https://gist.github.com/rinx/8231494/raw/f2d3115ab6057c1a83fab0f52c34432ce6f3a6c9/tex.vim -P $HOME/.vim/ftplugin/tex > /dev/null 2>&1
    echo -e "\033[0;32m✔ \033[1;36mA ftplugin 'tex.vim' downloaded in $HOME/.vim/ftplugin/tex\033[00m" | sed "s/^-e //"
fi


