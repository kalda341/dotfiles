#!/usr/bin/bash

get_focus() { [[ $1 == "true" ]] && echo 1 || echo 0; }

# read workspace data into an associative array
i=0
focus=0
declare -A ws_data
while read line; do
	[[ -z $line ]] && continue
	if (( i%2 == 0 )); then
		focus=$(get_focus "$line")
	else
		ws_data[$line]=$focus
	fi
	((i++))
done < <(i3-msg -t get_workspaces | jshon -a -e focused -u -p -e name -u)

# now output the data for all workspaces

for name in "${!ws_data[@]}"; do
    printf '${color%d}%s ' "${ws_data[$name]}" "$name"
done
