#!/usr/bin/env zsh
DOTFILES=$HOME/.dotfiles
STOW_FOLDERS=(zsh vim nvim)
cd $DOTFILES

for file in ./init/*; do
    echo "zsh $file"
    zsh $file
done

for folder in $STOW_FOLDERS; do
    echo "stow $folder"
    stow $folder
done
