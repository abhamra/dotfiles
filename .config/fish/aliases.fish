# Alias for git
alias g 'git'
alias ga 'git add .'
alias gcm 'git commit -m'
alias gfo 'git fetch origin'

alias spot 'flatpak run io.github.hrkfdn.ncspot'

alias piv 'pip install -v .'

# Alias nvim for vim
alias vim 'nvim'

# Alias for bat
alias cat 'bat'

# alias for eza
alias ls 'lo'

# venv stuff
alias v 'source venv/bin/activate.fish'

# reminder thing
function remind
    echo "notify-send '$argv[1]' -u critical" | at $argv[2] 2>/dev/null
end


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
alias cd 'z'

alias zola 'flatpak run org.getzola.zola'
