#!/bin/bash

service openclash start

# READ AUTH
if [ -f "/root/TeleWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TeleWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TeleWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Buat pesan notifikasi
MSG="❏ OC STARTED ❏"

# Mengirim pesan ke akun Telegram pribadi
URL="https://tgbotwrt.titit.tech/bot.jpg"
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto
