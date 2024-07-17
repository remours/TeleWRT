#!/bin/bash

service openclash restart

# READ AUTH
if [ -f "/root/TeleWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TeleWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TeleWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Buat pesan notifikasi
MSG="❏ OC RESTARTED ❏"

# Mengirim pesan ke akun Telegram pribadi
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto
