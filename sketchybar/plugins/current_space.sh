#!/bin/bash

inactive_spaces() {
	SPACES=$(yabai -m query --spaces | jq -cr '.[] | select(."has-focus" == false) | .index')
	for SPACE in $SPACES; do
		sketchybar --set $SPACE \
			background.color=0xff24273a \
			icon.color=0xffffffff
	done
}

active_space() {
	SPACE=$(yabai -m query --spaces --space | jq -r '.index')
	sketchybar --set $SPACE \
		background.color=0xfff5a97f \
		icon.color=0xff24273a
}

inactive_spaces
active_space
