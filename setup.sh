#!/bin/bash

if [ ! -d ~/dotconfig ]; then
    echo "Creating symlink to the configuration folder."
    ln -s `pwd` ~/dotconfig
else
    echo "Configuration folder is already sym-linked."
fi

# Dircolors

if [ ! -f ~/.dir_colors ]; then
    echo "Creating symlink to the .dir_colors."
    ln -s ~/dotconfig/dir_colors ~/.dir_colors
else
    echo ".dir_colors is already sym-linked."
fi

# TMUX

if [ ! -f ~/.tmux.conf ]; then
    echo "Creating symlink to the .tmux.conf."
    ln -s ~/dotconfig/tmux.conf ~/.tmux.conf
else
    echo ".tmux.conf is already sym-linked."
fi

