#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
source "$CURRENT_DIR/scripts/helpers.sh"

d_day_percentage="#($CURRENT_DIR/scripts/d_day_percentage.sh)"
d_day_remain="#($CURRENT_DIR/scripts/d_day_remain.sh)"
d_day_icon="#($CURRENT_DIR/scripts/d_day_icon.sh)"
d_day_percentage_interpolation="\#{d_day_percentage}"
d_day_remain_interpolation="\#{d_day_remain}"
d_day_icon_interpolation="\#{d_day_icon}"

set_tmux_option() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "$option" "$value"
}

do_interpolation() {
  local string="$1"
  local percentage_interpolated="${string/$d_day_percentage_interpolation/$d_day_percentage}"
  local remain_interpolated="${percentage_interpolated/$d_day_remain_interpolation/$d_day_remain}"
  local all_interpolated="${remain_interpolated/$d_day_icon_interpolation/$d_day_icon}"
  echo "$all_interpolated"
}

update_tmux_option() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}

main
