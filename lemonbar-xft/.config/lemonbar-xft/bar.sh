#!/bin/sh

RED="%{F#cd0000}"
YELLOW="%{F#cdcd00}"
RESET="%{F-}"

main() {
  while true; do
    update_bar
    sleep 5
  done
}

is_laptop() {
  [ "$(hostname -s)" = "openbsd-laptop" ]
}

update_bar() {
  if is_laptop; then
    printf "%%{l} %s | %s | %s | %s | %s %%{r} %s | %s | %s \n" \
      "$(battery)" \
      "$(temp)" \
      "$(cpu)" \
      "$(memory)" \
      "$(brightness)" \
      "$(volume)" \
      "$(wifi)" \
      "$(datetime)"
  else
    printf "%s | %s | %s | %s %%{r} %s | %s \n" \
      "$(temp)" \
      "$(cpu)" \
      "$(memory)" \
      "$(volume)" \
      "$(wifi)" \
      "$(datetime)"
  fi
}

battery() {
  apm_output=$(apm -al)
  percent=$(echo "$apm_output" | sed -n '1p')
  batt_state=$(echo "$apm_output" | sed -n '2p')
  minutes=$(apm -m)

  filled=$((percent / 10))
  bar=""
  i=0
  while [ $i -lt 10 ]; do
    if [ $i -lt $filled ]; then
      if [ "$batt_state" = "1" ]; then
        bar="${bar}+"
      else
        bar="${bar}#"
      fi
    else
      bar="${bar}-"
    fi
    i=$((i + 1))
  done

  if [ "$percent" -lt 30 ] && [ "$batt_state" != "1" ]; then
    bar="${RED}${bar}${RESET}"
  elif [ "$percent" -lt 50 ] && [ "$batt_state" != "1" ]; then
    bar="${YELLOW}${bar}${RESET}"
  fi

  printf "%s%% %s (%s min)" "$percent" "$bar" "$minutes"
}

temp() {
  avg=$(sysctl hw.sensors | awk -F'=' '/temp/ {
        gsub(/degC.*/, "", $2);
        sum += $2;
        count++
    } END {
        printf "%.0f", sum/count
    }')

  if [ "$avg" -ge 85 ]; then
    printf "%s%d°C%s" "$RED" "$avg" "$RESET"
  else
    printf "%d°C" "$avg"
  fi
}

cpu() {
  apm -Pv | awk '{gsub(/\(|\)/, ""); print $5, $6, $4}'
}

memory() {
  top -n | awk '/^Memory:/ {
        split($3, r, "/");
        printf "Used:%s Free:%s", r[2], $6
    }'
}

net() {
  ifconfig egress 2>/dev/null | awk '/inet / {print $2}'
}

brightness() {
  bright=$(xbacklight -get | cut -d. -f1)
  printf "Bri: %d%%" "$bright"
}

volume() {
  vol=$(sndioctl -n output.level)
  percent=$(printf "%.0f" "$(echo "$vol" | awk '{print $1 * 100}')")

  if sndioctl output.mute | grep -q "=1"; then
    printf "Vol: MUTE"
  else
    printf "Vol: %d%%" "$percent"
  fi
}

wifi() {
  wifi_info=$(ifconfig iwm0 2>/dev/null | grep "ieee80211:")
  if [ -n "$wifi_info" ]; then
    ssid=$(echo "$wifi_info" | sed -n 's/.*join \(.*\) chan.*/\1/p' | tr -d '"')
    signal=$(ifconfig iwm0 | awk '/ieee80211:/ {for(i=1;i<=NF;i++) if($i ~ /%/) print $i}' | head -1)
    printf "%s %s %s" "$ssid" "$signal" "$(net)"
  else
    net
  fi
}

datetime() {
  date '+%Y-%m-%d %H:%M'
}

main
