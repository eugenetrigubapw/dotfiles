#!/bin/sh

RED="%{F#cd0000}"
YELLOW="%{F#cdcd00}"
RESET="%{F-}"

net() {
  ifconfig egress 2>/dev/null | awk '/inet / {print $2}'
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

battery() {
  apm_output=$(apm -alb)
  ac_state=$(echo "$apm_output" | head -1)
  percent=$(echo "$apm_output" | sed -n '2p')
  charging=$(echo "$apm_output" | sed -n '4p')

  if [ "$ac_state" = "4" ]; then
    echo "AC"
    return
  fi

  filled=$((percent / 10))
  bar=""
  i=0
  while [ $i -lt 10 ]; do
    if [ $i -lt $filled ]; then
      if [ "$charging" = "1" ]; then
        bar="${bar}+"
      else
        bar="${bar}#"
      fi
    else
      bar="${bar}-"
    fi
    i=$((i + 1))
  done

  if [ "$percent" -lt 30 ] && [ "$charging" != "1" ]; then
    bar="${RED}${bar}${RESET}"
  elif [ "$percent" -lt 50 ] && [ "$charging" != "1" ]; then
    bar="${YELLOW}${bar}${RESET}"
  fi

  printf "%s%% %s" "$percent" "$bar"
}

cpu() {
  apm -Pv | awk '{gsub(/\(|\)/, ""); print $5, $6, $4}'
}

memory() {
  top -n | awk '/^Memory:/ {
        split($3, r, "/");
        printf "Used:%s Free:%s Cached:%s", r[2], $6, $8
    }'
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

datetime() {
  date '+%Y-%m-%d %H:%M'
}

while true; do
  printf "%%{l} %s | %s | %s | %s %%{r} %s | %s \n" \
    "$(battery)" \
    "$(temp)" \
    "$(cpu)" \
    "$(memory)" \
    "$(wifi)" \
    "$(datetime)"

  sleep 5
done
