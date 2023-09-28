# Shortform alias for commonly use command
alias c='clear'
alias lg='ls -lah | grep'
alias psg='ps -el | grep'
alias envg='env | grep'
alias dus='du -sh * | sort -h'

# Functions
vimw() {
    vim `which $1`
}

nvimw() {
    nvim `which $1`
}

catw() {
    cat `which $1`
}
