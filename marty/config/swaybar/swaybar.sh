date_formatted=$(date "+%a %F %H:%M:%S")

weather=$(curl -Ss 'https://wttr.in/Arnhem?0&T&Q&format=1')

audio_device=$(pactl info | grep 'Default Sink' | cut -d':' -f 2)

volume=$(pactl get-sink-volume $(pactl get-default-sink) | grep -i %)
audio_volume=$(echo "${volume:28:-51}")

interface=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')

ipbulk=$(ip -4 a show br0 | grep -i inet)
ip=$(echo "${ipbulk:9:-16}")

echo \| $interface \> $ip \| Audio Device: $audio_device \> Volume: $audio_volume \| $weather \| $date_formatted
