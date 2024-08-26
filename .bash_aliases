# alias for git
alias g='git'

alias piv='pip install -v .'

# alias nvim for vim
alias vim='nvim'

# function for tmux-sessionizer
# function tms(){
#     . ~/scripts/tmux-sessionizer.sh $1;
# }

# alias for bat
alias cat='batcat'

# venv stuff
alias v='. venv/bin/activate'

# TMUX ALIASES #

# tmux reattach named
function ta() {
    tmux attach -t "$1";
}

# tmux new named
function tn() {
    tmux new -t "$1";
}

alias tls='tmux ls'

# tmux kill session
function tks() {
    tmux kill-session -t "$1";
}

# tmux kill all sessions
alias tkser='tmux kill-server'

alias tmux='tmux -2'

# alias for zoxide
alias cd="z"
