# Shortform alias for commonly use command
alias c='clear'
alias lrtg='ls -lah | grep'
alias envg='env | grep'
alias psg='ps -el | grep'
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

ffind() {
    find . -iname "*$1*" 2>&1 | grep -E -v "Operation not permitted|Permission denied"
}
