#!/bin/bash

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=0xff8aadf4
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=0x60494d64
  slider.knob=􀀁
  # slider.knob.drawing=off
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  script="$PLUGIN_DIR/volume_click.sh"
  padding_left=10
  label=􀊩
  icon.width=0
  icon.align=left
  icon.color=0xff939ab7
  icon.font="$FONT_FACE:Regular:14.0"
  label.width=25
  label.align=left
  label.font="$FONT_FACE:Regular:14.0"
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                              mouse.entered     \
                              mouse.exited      \

sketchybar --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"
