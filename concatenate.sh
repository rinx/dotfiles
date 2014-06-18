#!/bin/sh

CMDNAME=`basename $0`
DOTDIR=$(cd $(dirname $0); pwd)
VIMDIR=$DOTDIR/vim.d

cat $VIMDIR/init_begin.vim \
    $VIMDIR/load_plugins.vim \
    $VIMDIR/basic.vim \
    $VIMDIR/color.vim \
    $VIMDIR/map.vim \
    $VIMDIR/filetype.vim \
    $VIMDIR/statusline.vim \
    $VIMDIR/init_end.vim \
    > vimrc_concatenated.vim

