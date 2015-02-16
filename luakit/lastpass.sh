#!/bin/bash
site=`echo $1 | egrep -o '^(http(s)?:\/\/)?[^/]+' | sed -r 's/http(s)?:\/\///'`
echo $site
lpass export | awk -F "," "/$site/ {print \$3}" | xclip -sel clip
