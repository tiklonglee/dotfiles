#!/usr/bin/env zsh
if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS=()
fi

pushd $DOTFILES
for folder in $STOW_FOLDERS
do
    echo "stow $folder"
    stow $folder
done
popd
