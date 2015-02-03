#!/usr/bin/bash

get_focus() { [[ $1 == "true" ]] && echo 1 || echo 0; }

# read workspace data into an associative array
i=0
focus=0
declare -A ws_data
prior_monitor=a
while read line; do
    [[ -z $line ]] && continue
    if (( i%3 == 0 )); then
        focus=$(get_focus "$line")
    elif (( i%3 == 1 )); then
        ws_data[$line]=$focus
#   else
#        if [ "$prior_monitor" != "$line" ]; then
#            #Do something to separare things
#        fi
    fi
    ((i++))
done < <(i3-msg -t get_workspaces | jshon -a -e focused -u -p -e name -u -p -e output -u)

for name in "${!ws_data[@]}"; do
    printf '${color%d}%s ' "${ws_data[$name]}" "$name"
done
