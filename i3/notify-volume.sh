volume=`pactl list sinks | awk '/Volume: front-left/ {print $5}'`
dunstify --replace=20 "Pulse Audio:\n Master Volume: $volume"
