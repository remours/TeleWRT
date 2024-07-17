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
❏ VNSTAT MONITOR
└ /vnstat -d - DAILY DATA USAGE
└ /vnstat -m - MONTHLY DATA USAGE
└ /vnstat -y - YEARLY DATA USAGE
"

# Mengirim pesan ke akun Telegram pribadi
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" \
