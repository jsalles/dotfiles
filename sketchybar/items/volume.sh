#!/usr/bin/env sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar	--add	item	volume right \
            --set volume \
                      icon.y_offset=1 \
                      icon.color=0xff8aadf4 \
                      label.drawing=no \
                      script="$PLUGIN_DIR/volume.sh" \
           --subscribe volume volume_change
