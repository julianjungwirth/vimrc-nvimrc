#!/bin/bash

minimal=0
color=0
force=0
while getopts mcf opt
do
	# echo "$opt"
	case $opt in
		m)
			minimal=1
			echo "installing minimal setup"
			;;
		c) 
			color=1
			echo "installing color scheme"
			;;
		f)	force=1
			echo "deleting old files"
			;;
		\?)
			echo >&2 \
				"usage: $0 [-m] [-c] [-f]"
			exit 1;;
	esac
done


#vimrc
mkdir -p ~/.config/nvim/backup
mkdir -p ~/.config/nvim/swap
#remove old files
if [ $force -eq 1 ]
then
	rm ~/.vimrc
	rm ~/.config/nvim/init.vim
fi
#create symlinks
ln -s "$(pwd)/init.vim" ~/.vimrc
ln -s "$(pwd)/init.vim" ~/.config/nvim/init.vim


#Colorscheme
if [ $color -eq 1 ]
	if [ $force -eq 1 ]
	then
		rm ~/.vim/colors/noctu2.vim
		rm ~/.config/nvim/colors/noctu2.vim
	fi
then
	mkdir -p ~/.vim/colors
	mkdir -p ~/.config/nvim/colors
	ln -s "$(pwd)/noctu2.vim" ~/.vim/colors/noctu2.vim
	ln -s "$(pwd)/noctu2.vim" ~/.config/nvim/colors/noctu2.vim
fi

#install plugin manager for nvim
if [ $minimal -eq 0 ] 
then
	echo "installing dein plugin manager"
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh installer.sh ~/.config/nvim/dein
fi

