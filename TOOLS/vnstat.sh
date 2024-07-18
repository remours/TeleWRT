#!/bin/sh

# READ AUTH
if [ -f "/root/TeleWRT/AUTH" ]; then
    BOT_TOKEN=$(head -n 1 /root/TeleWRT/AUTH)
    CHAT_ID=$(tail -n 1 /root/TeleWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Fungsi untuk mengirim pesan ke bot Telegram
send_telegram_message() {
    chat_id="$1"
    message="$2"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$chat_id&text=$message" > /dev/null
}

# Fungsi untuk mengambil data download, upload, dan total dari vnstat
get_daily_bandwidth() {
    vnstat_day=$(vnstat -i br-lan -d 1 --style 0 | sed -n 6p)
    vnstat_month=$(vnstat -i br-lan -m 1 --style 0 | sed -n 6p)
    vnstat_year=$(vnstat -i br-lan -y 1 --style 0 | sed -n 6p)
    down_day=$(echo "$vnstat_day" | awk '{print $5, $6}')
    down_month=$(echo "$vnstat_month" | awk '{print $5, $6}')
    down_year=$(echo "$vnstat_year" | awk '{print $5, $6}')
    up_day=$(echo "$vnstat_day" | awk '{print $2, $3}')
    up_month=$(echo "$vnstat_month" | awk '{print $2, $3}')
    up_year=$(echo "$vnstat_year" | awk '{print $2, $3}')
    total_day=$(echo "$vnstat_day" | awk '{print $8, $9}')
    total_month=$(echo "$vnstat_month" | awk '{print $8, $9}')
    total_year=$(echo "$vnstat_year" | awk '{print $8, $9}')
    
    echo "
╔══ 𝗕𝗔𝗡𝗗𝗪𝗜𝗧𝗛 𝗨𝗦𝗔𝗚𝗘 𝗥𝗘𝗣𝗢𝗥𝗧 📊
║
╠ ⛱️ 𝗥𝗲𝗺𝗮𝗿𝗸𝘀 ☞ 𝗨𝘀𝗲𝗿-𝗪𝗥𝗧 😈
╠ 🚀 𝗦𝘁𝗮𝘁𝘂𝘀 ☞ 𝗢𝗻𝗹𝗶𝗻𝗲 ✅
║
╠══ 𝗗𝗔𝗜𝗟𝗬 𝗨𝗦𝗔𝗚𝗘 😋
╠ 📥 $down_day | 📤 $up_day
╠ 📊 𝗧𝗢𝗧𝗔𝗟 ☞ $total_day
║
╠══ 𝗠𝗢𝗡𝗧𝗛𝗟𝗬 𝗨𝗦𝗔𝗚𝗘 😋
╠ 📥 $down_month | 📤 $up_month
╠ 📊 𝗧𝗢𝗧𝗔𝗟 ☞ $total_month
║
╠══ 𝗬𝗘𝗔𝗥𝗟𝗬 𝗨𝗦𝗔𝗚𝗘 😋
╠ 📥 $down_year | 📤 $up_year
╠ 📊 𝗧𝗢𝗧𝗔𝗟 ☞ $total_year
║
╠ ⚠️ 𝗔𝘂𝘁𝗼𝗺𝗮𝘁𝗶𝗰 𝗠𝗶𝗱𝗻𝗶𝗴𝗵𝘁 𝗨𝗽𝗱𝗮𝘁𝗲 ⚠️
║
╚ ⏰ 𝗟𝗔𝗦𝗧 𝗨𝗣𝗗𝗔𝗧𝗘: $(date +'%d-%m-%Y %I:%M %p')
"
}

# Main program
bandwidth_message=$(get_daily_bandwidth)

# Mengirim pesan ke akun Telegram pribadi
send_telegram_message "$CHAT_ID" "$bandwidth_message"

