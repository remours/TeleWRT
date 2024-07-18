#!/bin/sh

# READ AUTH
if [ -f "/root/TeleWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TeleWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TeleWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Generate the system status report
MSG="
❏ MONITORING BOT 🚀
└ System Information:
└ Hostname: $(uci get system.@system[0].hostname | tr -d '\0')
└ Model: $(cat /proc/device-tree/model | tr -d '\0')
└ Architecture: $(uname -m)
└ Firmware: $(cat /etc/openwrt_release | grep DISTRIB_DESCRIPTION | cut -d "'" -f 2 | tr -d '\0')
└ Platform: $(cat /etc/openwrt_release | grep DISTRIB_TARGET | cut -d "'" -f 2 | tr -d '\0')
└ Kernel: $(uname -r)
└ Date: $(date +"%d %b %Y | %I:%M %p")
└ Uptime: $(uptime | awk '{print $3,$4}' | sed 's/,.*//')
└ Temp: $(awk '{printf "%.2f°C\n", $1/1000}' /sys/class/thermal/thermal_zone0/temp)
└ Load Average: $(awk '{printf "%.0f%%", $1 * 100}' /proc/loadavg)
└ CPU: $(mpstat 1 1 | tail -n 1 | awk '{printf "%.2f%%", 100 - $NF}')
"

# Mengirim pesan ke akun Telegram pribadi
curl -F "chat_id=$CHAT_ID" -F "text=$MSG" \
https://api.telegram.org/bot$BOT_TOKEN/sendMessage
