#!/usr/bin/env sh 

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar 	--add item front_app center \
            --set   front_app \
                          background.padding_left=0 \
                          background.padding_right=0 \
                          icon.y_offset=1 \
                          label.drawing=no \
                          script="$PLUGIN_DIR/front_app.sh" \
          --add item front_app.name center \
          --set front_app.name \
                    icon.drawing=off \
                    label="Hello" \
                    label.drawing=yes

sketchybar  --add   bracket front_app_bracket \
                    front_app \
                    front_app.separator \
                    front_app.name \
            --subscribe	front_app front_app_switched \
