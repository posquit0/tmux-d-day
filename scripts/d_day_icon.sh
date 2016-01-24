#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

get_d_day_setting() {
  d_day_icon=$( get_tmux_option "@d_day_icon" "" )
}

print_d_day_icon() {
  printf "%s" "$d_day_icon"
}

main() {
  get_d_day_setting
  print_d_day_icon
}

main
