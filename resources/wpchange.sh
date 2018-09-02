#!/bin/sh

BASE_DIR=~/.wallpapers

rm -f ${BASE_DIR}/wallpaper.jpg

image_list=(${BASE_DIR}/*.jpg)
numimglist=${#image_list[@]}
rannum=$(( $RANDOM % ${numimglist}))
image_path=${image_list[$rannum]}

ln -s $image_path ${BASE_DIR}/wallpaper.jpg
