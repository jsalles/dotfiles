#!/usr/bin/env sh

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"
sketchybar --add item spotify_playlist e \
	--set spotify_playlist \
	background.padding_left=-5 \
	background.color=0xaa24273a \
	icon= \
	icon.color=0xffc6a0f6 \
	icon.font="$FONT_FACE:Bold:19.0" \
	label.drawing=off \
	script="$PLUGIN_DIR/spotify_playlist.sh" \
	--subscribe spotify_playlist mouse.clicked

sketchybar --add event spotify_change $SPOTIFY_EVENT \
	--add item spotify e \
	--set spotify \
	icon= \
	icon.font="$FONT_FACE:Bold:20.0" \
	icon.y_offset=1 \
	label.drawing=off \
	label.padding_left=2 \
	script="$PLUGIN_DIR/spotify.sh" \
	--subscribe spotify spotify_change mouse.clicked
