#!/usr/bin/env zsh
if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS=(zsh)
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

pushd $DOTFILES
for folder in $STOW_FOLDERS
do
    echo "stow $folder"
    stow $folder
done
popd
