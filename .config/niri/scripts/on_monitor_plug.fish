#!/usr/bin/env fish

# Target external monitor name
set TARGET_MONITOR "DP-2"
set TARGET_WORKSPACE "research"

# Get window IDs belonging to windows on the 'research' workspace
set window_ids (niri msg --json windows | jq -r ".[] | select(.workspace_id == \"$TARGET_WORKSPACE\") | .id")

if test -n "$window_ids"
    # Save currently focused window ID to restore focus later
    set initial_focus (niri msg --json focused-window | jq -r '.id // empty')

    for id in $window_ids
        # Focus window so operations apply to its column
        niri msg action focus-window --id $id
        # Move column to the external monitor
        niri msg action move-column-to-monitor $TARGET_MONITOR
    end

    # Restore initial focus if it existed
    if test -n "$initial_focus"
        niri msg action focus-window --id $initial_focus
    end
end
