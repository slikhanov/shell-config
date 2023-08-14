#!/bin/bash

if [ ! -f ~/.p10k.zsh ]; then
    echo "Creating symlink to the .p10k.zsh."
    ln -s `pwd`/.p10k.zsh ~/.p10k.zsh

    echo "Appending local configuration to .zshrc."
    cat `pwd`/.zshrc.my >> ~/.zshrc
else
    echo ".p10k.zsh is already sym-linked."
fi
