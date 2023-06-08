#!/usr/bin/env sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar  --add   item clock right \
            --set   clock \
                        icon= \
                        icon.y_offset=1 \
                        icon.color=0xffed8796 \
                        update_freq=10 \
                        script="$PLUGIN_DIR/clock.sh"
