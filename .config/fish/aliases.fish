# Alias for git
alias g 'git'

alias gfo 'git fetch origin'

alias piv 'pip install -v .'

# Alias nvim for vim
alias vim 'nvim'

# Alias for bat
alias cat 'batcat'

# venv stuff
alias v 'source venv/bin/activate.fish'

# TMUX ALIASES #

# tmux reattach named
function ta
    tmux attach -t "$argv[1]"
end

# tmux new named
function tn
    tmux new -t "$argv[1]"
end

alias tls 'tmux ls'

# tmux kill session
function tks
    tmux kill-session -t "$argv[1]"
end

# tmux kill all sessions
alias tkser 'tmux kill-server'

alias tmux 'tmux -2'

# for downloads
function download
    sudo dpkg -i "$argv[1]"
end

# Alias for zoxide
# alias cd 'z'
set --universal zoxide_cmd c
