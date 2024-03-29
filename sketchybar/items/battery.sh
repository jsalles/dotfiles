#!/usr/bin/env sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar  --add   item battery right \
            --set   battery \
                        icon.y_offset=1 \
                        update_freq=10 \
                        script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke
