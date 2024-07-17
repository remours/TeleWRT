#!/bin/bash

service edy restart

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Buat pesan notifikasi
MSG="❏ BOT RESTARTED ❏"

# Mengirim pesan ke akun Telegram pribadi
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" \
