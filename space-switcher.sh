#!/bin/dash

window_in_space()
{
  local target=$1
  echo $(yabai -m query --spaces | jq --arg target $target 'map(select(.label == $target))[-1] | .windows[0]')
}

focus_space()
{
  local target_space=$1
  local window_in_target_space=$(window_in_space $target_space)

  if [ $window_in_target_space = null ]; 
  then
    echo "not implemented"
  else
    $(yabai -m window --focus $window_in_target_space)
  fi
}

move_window()
{
  local target_space=$1
  local current_window=`yabai -m query --windows --window | \
    jq '.id'`
  $(yabai -m window --space $target_space)
  $(yabai -m window --focus $current_window)
}

case $1 in
  space)
    focus_space "$2"
    ;;
  window)
    move_window "$2"
    ;;
esac
