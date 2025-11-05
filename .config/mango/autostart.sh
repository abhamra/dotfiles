#! /usr/bin/fish

set +e

# notify
swaync &

# night light, can update for diff lat/Long
wlsunset -l 33.7 -L -84.4 &

# wallpaper
swaybg -i ~/Pictures/firewatch.png &

# top bar
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css &

# keep clipboard content
~/pkgs/wl-clip-persist/target/release/wl-clip-persist --clipboard regular --reconnect-tries 0 &

# clipboard content manager
wl-paste --type text --watch cliphist store & 

# start xwayland
~/projects/xwayland-satellite :1 &
sleep 0.5s && echo "Xft.dpi: 190" | xrdb -merge

# # xwayland dpi scale
# echo "Xft.dpi: 140" | xrdb -merge
gsettings set org.gnome.desktop.interface text-scaling-factor 1.9

# Permission authentication
/usr/libexec/xfce-polkit &

