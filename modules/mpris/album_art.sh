
#!/bin/bash

write_art() {
   album_art=$(playerctl -p $1 metadata mpris:artUrl)
   status=$?
   if [[ -z $album_art || $status -eq 0 ]] 
   then
        album_art=$(playerctl metadata mpris:artUrl)
        if [[ -z $album_art ]]
        then
            exit
        fi
   fi
   
   curl -s "${album_art}" --output "/tmp/cover.jpeg"
   echo "/tmp/cover.jpeg"
}




read -d'\n' -ra PLAYERS <<<"$(playerctl -l 2>/dev/null)"
declare -a PAUSED
for player in "${PLAYERS[@]}"; do
    [ "$player" = "playerctld" ] && continue;

    p_status=$(playerctl -p "$player" status 2>/dev/null)

    # if we have one playing, we'll use it and EXIT
    if [ "$p_status" = "Playing"  ]; then
        write_art "$player"
        exit 0;
    fi

    [ "$p_status" = "Paused" ] && PAUSED+=("$player")
done

if [ -n "${PAUSED[0]}" ]; then
    write_art "${PAUSED[0]}"
fi
