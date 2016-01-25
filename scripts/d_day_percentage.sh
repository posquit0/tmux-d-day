#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

get_d_day_setting() {
  d_day_percentage_prefix=$( get_tmux_option "@d_day_percentage_prefix" "" )
  d_day_percentage_postfix=$( get_tmux_option "@d_day_percentage_postfix" "%" )
  d_day_start_date=$( get_tmux_option "@d_day_start_date" "" )
  d_day_end_date=$( get_tmux_option "@d_day_end_date" "today 0" )
}

date_diff() {
  local d1=$( date -d "$1" +%s )
  local d2=$( date -d "$2" +%s )

  if (( (d1 - d2) < 0 )); then
    echo $(( ((d1 - d2) - (60 * 60 * 12)) / (60 * 60 * 24) ))
  else
    echo $(( (d1 - d2) / (60 * 60 * 24) ))
  fi
}

print_d_day_percentage() {
  local today="today 0"

  if [ "$d_day_start_date" != "" ]; then
    local entire=$(
      date_diff "$d_day_start_date" "$d_day_end_date"
    )
    local passed=$( date_diff "$d_day_start_date" "$today" )
    local percentage=$(( 100 * passed / entire ))
    percentage=$(( percentage > 100 ? 100 : percentage ))

    printf "%s" "$d_day_percentage_prefix$percentage$d_day_percentage_postfix"
  else
    printf ""
  fi
}

main() {
  get_d_day_setting
  print_d_day_percentage
}

main
