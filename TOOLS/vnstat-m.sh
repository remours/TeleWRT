#!/bin/bash

# READ AUTH
if [ -f "/root/TeleWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TeleWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TeleWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Fungsi untuk mengambil data download, upload, dan total dari vnstat
get_daily_bandwidth() {
    vnstat_output=$(vnstat -i br-lan -m 1 --style 0 | sed -n 6p)
    download=$(echo "$vnstat_output" | awk '{print $5, $6}')
    upload=$(echo "$vnstat_output" | awk '{print $2, $3}')
    total=$(echo "$vnstat_output" | awk '{print $8, $9}')
    
    echo "
❏ BANDWIDTH MONTHLY USAGE
└ DOWNLOAD: $download
└ UPLOAD: $upload
└ TOTAL: $total
└ DATE: $(date +'%d-%m-%Y %I:%M %p')
"
}

# Main program
get_ip_info
MSG=$(get_daily_bandwidth)

# Mengirim pesan ke akun Telegram pribadi
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto
