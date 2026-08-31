#!/usr/bin/env fish

# Path to state file tracking monitor connection status
set STATE_FILE "/tmp/niri_monitor_state"

# for when we connect to DP-2
function get_dp2_status
    niri msg --json outputs | jq -e 'has("DP-2")' >/dev/null
    return $status
end

# Initialize current state
if get_dp2_status
    echo "connected" > $STATE_FILE
else
    echo "disconnected" > $STATE_FILE
end

# Listen to Niri event stream continuous JSON output
niri msg --json event-stream | while read -l line
    # Check if event is OutputChanged
    set is_output_event (echo $line | jq -r 'has("OutputChanged")')

    if test "$is_output_event" = "true"
        set last_state (cat $STATE_FILE 2>/dev/null)
        
        if get_dp2_status
            if test "$last_state" != "connected"
                echo "connected" > $STATE_FILE
                echo "[Niri Layout] DP-2 Connected. Executing plug handler..."
                ~/.config/niri/scripts/on_monitor_plug.fish
            end
        else
            if test "$last_state" != "disconnected"
                echo "disconnected" > $STATE_FILE
                echo "[Niri Layout] DP-2 Disconnected. Executing unplug handler..."
                ~/.config/niri/scripts/on_monitor_unplug.fish
            end
        end
    end
end
