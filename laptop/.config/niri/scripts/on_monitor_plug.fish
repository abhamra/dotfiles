#!/usr/bin/env fish

set TARGET_MONITOR "DP-2"
set TARGET_WORKSPACE_NAME "research"

# 1. Resolve workspace ID for research
set target_ws_id (niri msg --json workspaces | jq -r ".[] | select(.name == \"$TARGET_WORKSPACE_NAME\") | .id")

# 2. Focus research workspace and ensure it resides on DP-2
niri msg action focus-workspace "$TARGET_WORKSPACE_NAME"
niri msg action move-workspace-to-monitor "$TARGET_MONITOR"

# 3. Move any existing columns matching research apps to DP-2
set window_ids (niri msg --json windows | jq -r '.[] | select(.app_id != null and (.app_id | test("zathura|md.obsidian.Obsidian|org.zotero.Zotero"; "i"))) | .id')

for id in $window_ids
    niri msg action focus-window --id $id
    niri msg action move-column-to-monitor $TARGET_MONITOR
end

# Return focus to primary workspace on laptop screen
niri msg action focus-workspace "browser"
