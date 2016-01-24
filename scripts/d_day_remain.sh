#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

# Global Variables
is_overdue="true"

get_d_day_setting() {
  d_day_remain_prefix=$( get_tmux_option "@d_day_remain_prefix" "D" )
  d_day_remain_postfix=$( get_tmux_option "@d_day_remain_postfix" "" )
  d_day_remain_plus_sign=$( get_tmux_option "@d_day_remain_plus_sign" "+" )
  d_day_remain_minus_sign=$( get_tmux_option "@d_day_remain_minus_sign" "-" )
  d_day_end_date=$( get_tmux_option "@d_day_end_date" "today" )
  d_day_the_day=$( get_tmux_option "@d_day_the_day" "D-Day" )
}

date_diff() {
  local d1=$( date -d "$1" +%s )
  local d2=$( date -d "$2" +%s )

  if (( d1 < d2 )); then
    is_overdue="false"
  else
    is_overdue="true"
  fi
  echo $(( ((d1 - d2) > 0 ? (d1 - d2) : (d2 - d1)) / (60 * 60 * 24) ))
}

print_d_day_remain() {
  local today="today"

  local days=$( date_diff "$today" "$d_day_end_date" )

  if (( days == 0 )); then
    echo "$d_day_the_day"
  else
    if [ $is_overdue != "true" ]; then
      local days="$d_day_remain_minus_sign$days"
    else
      local days="$d_day_remain_plus_sign$days"
    fi
    echo "$d_day_remain_prefix$days$d_day_remain_postfix"
  fi
}

main() {
  get_d_day_setting
  print_d_day_remain
}

main