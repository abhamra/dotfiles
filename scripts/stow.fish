#!/usr/bin/fish

# Get the current hostname (you can also change this to check a specific environment variable if you prefer)
set current_host (hostname)

echo "Detected hostname: $current_host"

# Always stow common files
echo "Stowing common configuration..."
stow -t ~ common

# Conditional stow based on machine name
# Replace 'my-laptop-name' and 'homeserver' with your actual hostnames
switch $current_host
    case "laptop" "pc"
        echo "Stowing laptop configuration..."
        stow -t ~ laptop
    case "homeserver" "homeserver-hostname"
        echo "Stowing homeserver configuration..."
        echo "Note: Stowing to root (/) for homeserver"
        # Since you mentioned stowing to / for homeserver, use sudo if needed:
        sudo stow -t / homeserver
    case '*'
        echo "Unknown hostname '$current_host'. Only common configurations were stowed."
        exit 1
end

echo "Dotfiles successfully deployed!"
