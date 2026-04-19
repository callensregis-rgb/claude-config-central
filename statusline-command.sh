#!/bin/bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

parts=()

[ -n "$model" ] && parts+=("$model")
[ -n "$used_pct" ] && parts+=("ctx:$(printf '%.0f' "$used_pct")%")
[ -n "$five_pct" ] && parts+=("5h:$(printf '%.0f' "$five_pct")%")
[ -n "$week_pct" ] && parts+=("7d:$(printf '%.0f' "$week_pct")%")

printf '%s' "$(IFS=' | '; echo "${parts[*]}")"
