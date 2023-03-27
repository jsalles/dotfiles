#!/usr/bin/env sh

inactive_spaces() {
	SPACES=$(yabai -m query --spaces | jq -cr '.[] | select(."has-focus" == false) | if .label == "" then .index else .label end')
	for SPACE in $SPACES; do
		sketchybar --set $SPACE \
			background.color=0x01010101 \
			icon.color=0xffffffff
	done
	echo "End of inactive spaces" >>"$HOME/dotfiles/sketchybar/output.txt"
}

active_space() {
	SPACE=$(yabai -m query --spaces --space | jq -r 'if .label == "" then .index else .label end')
	sketchybar --set $SPACE \
		background.color=0xfff5a97f \
		icon.color=0xff24273a
}

# update_space() {
#   # SPACE_ID=$(echo "$INFO" | jq -r '."label"')
#   SPACE_ID=$(yabai -m query --spaces --space | jq -r '.label')
#   echo $SPACE_ID >> "$HOME/dotfiles/sketchybar/output.txt"
#
#   case $SPACE_ID in
#     1)
#       ICON=
#       ICON_PADDING=7
#       ;;
#     *)
#       ICON=$SPACE_ID
#       ICON_PADDING=10
#       ;;
#   esac
#
#   sketchybar --set $NAME \
#     icon=$ICON \
#     icon.padding_left=$ICON_PADDING \
#     icon.padding_right=$ICON_PADDING
#
# }

# case "$SENDER" in
#   "mouse.clicked")
#     # Reload sketchybar
#     sketchybar --remove '/.*/'
#     source $HOME/.config/sketchybar/sketchybarrc
#     ;;
#   *)
#     update_space
#     ;;
# esac
inactive_spaces
active_space
