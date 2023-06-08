#!/bin/bash

switch_space() {
  echo "Space clicked $NAME" >> ~/dotfiles/sketchybar/output.txt
  yabai -m space --focus $NAME
}

switch_space
