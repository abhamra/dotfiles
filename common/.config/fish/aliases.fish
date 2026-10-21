if test (hostname) = "homeserver";
    alias battery 'acpi -b'
    alias rebuild 'sudo nixos-rebuild switch'
    alias nixconf 'vim ~/dotfiles/homeserver/etc/nixos/configuration.nix'
end
if test (hostname) = "pc";
    alias mail 'aerc'
    alias now './scripts/now_page.fish'

    # reminder thing
    function remind
        echo "notify-send '$argv[1]' -u critical" | at $argv[2] 2>/dev/null
    end

    alias doom '~/.emacs.d/bin/doom'

    alias zz '$HOME/scripts/zotero_zathura.fish'

    # for downloads
    function download
        sudo dpkg -i "$argv[1]"
    end

    alias zola 'flatpak run org.getzola.zola'
end
# Alias for git
alias g 'git'
alias ga 'git add .'
# alias gcm 'git commit -m'
abbr --add gcm --set-cursor 'git commit -m "%"' 
alias gfo 'git fetch origin'

alias piv 'pip install -v .'

# Alias nvim for vim
alias vim 'nvim'

# Alias for bat
alias cat 'bat'

# alias for eza
# alias ls 'lo'

# venv stuff
alias v 'source venv/bin/activate.fish'
alias cv 'python3 -m venv venv'

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

# Alias for zoxide
alias cd 'z'
