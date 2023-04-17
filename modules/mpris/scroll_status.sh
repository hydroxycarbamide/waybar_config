#!/bin/bash

cmd="${0%/*}/get_status.sh $1"

zscroll -l 30 \
    --scroll-padding "$(printf ' %.0s' {1..8})" \
    -d 0.5 \
    -M "${0%/*}/get_status_paused.sh $1" \
    -m "Playing" "--scroll 1" \
    -m "Paused" "--scroll 0" \
    -m "Stopped" "--scroll 0" \
    -U 5 -u true "$cmd" &

wait

