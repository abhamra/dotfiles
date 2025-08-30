-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.font_size = 11
config.initial_cols = 76
config.color_scheme = 'rose-pine'
-- when I want to move from tmux, I will re-enable this!
config.enable_tab_bar = false
config.window_background_opacity = 0.9
config.font = wezterm.font 'Berkeley Mono'
config.window_close_confirmation = 'NeverPrompt'

-- Finally, return the configuration to wezterm:
return config
