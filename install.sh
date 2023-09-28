#!/usr/bin/env zsh
if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS=(zsh vim)
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

pushd $DOTFILES
for folder in $STOW_FOLDERS
do
    echo "stow $folder"
    stow $folder
done
popd
