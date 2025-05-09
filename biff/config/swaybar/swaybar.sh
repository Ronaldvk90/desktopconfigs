# Date and time
date_formatted=$(date "+%a %F %H:%M:%S")

# Weather
weather=$(curl -Ss 'https://wttr.in/Arnhem?0&T&Q&format=1')

# Battery Status (if present)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Audio Device
audio_device=$(pactl info | grep 'Default Sink' | cut -d':' -f 2)

# Audio Volume
volume=$(pactl get-sink-volume $(pactl get-default-sink) | grep -i %)
audio_volume=$(echo "${volume:29:-51}")

# Network interface and connected WiFi network
interface=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
wifi_network=$(iwgetid -r)
ipbulk=$(ip -4 a show wlp3s0 | grep -i inet)
ip=$(echo "${ipbulk:9:-59}")

# Put it all together
echo \| Battery: $battery_status \| $interface \> Wifi Network: $wifi_network \> $ip \| Audio Device: $audio_device \> Volume: $audio_volume \| $weather \| $date_formatted
