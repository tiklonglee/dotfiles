#!/usr/bin/env zsh
DOTFILES=$HOME/.dotfiles
STOW_FOLDERS=()
cd $DOTFILES

for folder in $STOW_FOLDERS; do
    echo "stow $folder"
    stow $folder
done
