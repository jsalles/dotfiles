#!/bin/bash

yabai -m query --spaces | jq -cr 'map({ label: .label, index: .index, active: ."has-focus" }) | .[]' | while read -r SPACE; do
	SPACE_INDEX=$(echo $SPACE | jq -r '.index')
	SPACE_NAME=$(echo $SPACE | jq -r 'if .label == "" then .index else .label end')
	ACTIVE=$(echo $SPACE | jq -r '.active')
	BACKGROUND_COLOR=0xff24273a
	FONT_COLOR=0xffffffff
	if $ACTIVE; then
		BACKGROUND_COLOR=0xfff5a97f
		FONT_COLOR=0xff24273a
	fi

	space=(
    click_script="$PLUGIN_DIR/space_click.sh"
		background.color=$BACKGROUND_COLOR
		background.padding_right=5
		icon=$SPACE_NAME
		icon.font="$FONT_FACE:Bold:13.0"
		icon.color="$FONT_COLOR"
		label.drawing=off
	)

	sketchybar --add item "$SPACE_INDEX" left \
		--set "$SPACE_INDEX" "${space[@]}" \
    --subscribe "$SPACE_INDEX" mouse.clicked
done

updater=(
	drawing=on
	background.color=0x00000000
	script="$PLUGIN_DIR/current_space.sh"
)
sketchybar --add item space_updater left \
	--set space_updater "${updater[@]}" \
	--subscribe space_updater space_change mouse.clicked
