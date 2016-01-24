#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

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

  echo $(( (d1 - d2) / (60 * 60 * 24) ))
}

print_d_day_remain() {
  local today="today"

  local days=$( date_diff "$today" "$d_day_end_date" )
  local is_overdue=$(( days > 0 ))
  days=$(( days > 0 ? days : -days ))

  if (( days == 0 )); then
    printf "%s" "$d_day_the_day"
  else
    if (( is_overdue )); then
      local days="$d_day_remain_plus_sign$days"
    else
      local days="$d_day_remain_minus_sign$days"
    fi
    printf "%s" "$d_day_remain_prefix$days$d_day_remain_postfix"
  fi
}

main() {
  get_d_day_setting
  print_d_day_remain
}

main