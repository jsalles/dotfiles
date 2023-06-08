#!/usr/bin/env sh

SPACES=$(yabai -m query --spaces | jq -r 'map({ label: .label, active: ."has-focus" })' | jq -cr '.[] | [.label, .active|tostring] | join(",")')
for SPACE in $SPACES
do
  SPACE_NAME=$(echo "$SPACE" | awk -F',' '{printf $1}')
  ACTIVE=$(echo "$SPACE" | awk -F',' '{printf $2}')
  BACKGROUND_COLOR=0x01010101 
  FONT_COLOR=0xffffffff
  if $ACTIVE; then 
    BACKGROUND_COLOR=0xfff5a97f
    FONT_COLOR=0xff24273a
  fi
  sketchybar	--add	item $SPACE_NAME left \
              --set	$SPACE_NAME \
                          background.color="$BACKGROUND_COLOR" \
                          background.padding_right=5 \
                          icon="$SPACE_NAME" \
                          icon.font="$FONT_FACE:Bold:13.0" \
                          icon.color="$FONT_COLOR" \
                          label.drawing=off 
                            # icon.color=0xff24273a \
done
