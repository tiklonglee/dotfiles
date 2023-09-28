# ZSH oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gozilla"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking

export ZSH_COMPDUMP=~/.cache/zsh/.zcompdump

source $ZSH/oh-my-zsh.sh

# User configuration
unset LESS
for file in ~/.zsh/*; do
    source $file
done
