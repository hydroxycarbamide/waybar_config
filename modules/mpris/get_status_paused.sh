#!/bin/bash

# manually go through players
read -d'\n' -ra PLAYERS <<<"$(playerctl -l 2>/dev/null)"
declare -a PAUSED
for player in "${PLAYERS[@]}"; do
    [ "$player" = "playerctld" ] && continue;

    p_status=$(playerctl -p "$player" status 2>/dev/null)

    # if we have one playing, we'll use it and EXIT
    if [ "$p_status" = "Playing"  ]; then
        echo "Playing"
        exit 0;
    fi
done

echo "Paused"
