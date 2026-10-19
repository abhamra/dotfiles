#!/usr/bin/env fish

set TARGET_WORKSPACE "research"

# 1. Target windows that belong to the research workspace and push them back onto 'research'
set research_window_ids (niri msg --json windows | jq -r ".[] | select(.workspace_id == \"$TARGET_WORKSPACE\") | .id")

for id in $research_window_ids
    niri msg action focus-window --id $id
    niri msg action move-column-to-workspace $TARGET_WORKSPACE
end

# 2. Re-sequence workspace order on eDP-1: browser (1), chat and misc (2), research (3)
# Focusing workspaces in sequence ensures Niri arranges dynamic index ordering correctly.
niri msg action focus-workspace "browser"
niri msg action focus-workspace "chat and misc"
niri msg action focus-workspace "research"

# Return focus back to browser as primary workspace
niri msg action focus-workspace "browser"
