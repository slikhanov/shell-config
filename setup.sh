#!/bin/bash

if [ ! -d ~/dotconfig ]; then
    echo "Creating symlink to the configuration folder."
    ln -s `pwd` ~/dotconfig
else
    echo "Configuration folder is already sym-linked."
fi

if [ ! -f ~/.tmux.conf ]; then
    echo "Creating symlink to the .tmux.conf."
    ln -s ~/dotconfig/tmux.conf ~/.tmux.conf
else
    echo ".tmux.conf is already sym-linked."
fi

