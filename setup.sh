#!/bin/bash

# Define color codes properly
RED='\033[1;31m'
GRN='\033[1;32m'
YLW='\033[1;33m'
CYAN='\033[1;36m'
RST='\033[0m'

clear
echo -e "${CYAN}🔧 RedEye Setup Script Starting...${RST}"
echo

# PHP check
if ! command -v php &>/dev/null; then
    echo -e "${YLW}⚙️ PHP not found. Installing...${RST}"
    sudo apt update && sudo apt install php -y
else
    echo -e "${GRN}✅ PHP is installed.${RST}"
fi

# Git check
if ! command -v git &>/dev/null; then
    echo -e "${YLW}⚙️ Git not found. Installing...${RST}"
    sudo apt update && sudo apt install git -y
else
    echo -e "${GRN}✅ Git is installed.${RST}"
fi

# Ngrok check
if ! command -v ngrok &>/dev/null; then
    echo -e "${YLW}⚙️ Ngrok not found. Downloading...${RST}"
    wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip -O ngrok.zip
    unzip -o ngrok.zip
    sudo mv ngrok /usr/local/bin/
    rm ngrok.zip
else
    echo -e "${GRN}✅ Ngrok is installed.${RST}"
fi

# Cloudflared check
if ! command -v cloudflared &>/dev/null; then
    echo -e "${YLW}⚙️ Cloudflared not found. Installing...${RST}"
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared
    chmod +x cloudflared
    sudo mv cloudflared /usr/local/bin/
else
    echo -e "${GRN}✅ Cloudflared is installed.${RST}"
fi

# logs folder check
if [ ! -d "logs" ]; then
    echo -e "${YLW}📁 Creating logs/ directory...${RST}"
    mkdir logs
else
    echo -e "${GRN}✅ logs/ directory exists.${RST}"
fi

# sites folder check
if [ ! -d "sites" ]; then
    echo -e "${RED}❌ 'sites/' directory is missing! Please create or clone your templates into it.${RST}"
    exit 1
else
    echo -e "${GRN}✅ sites/ directory found.${RST}"
fi

echo
echo -e "${CYAN}✅ Setup complete. Run with: ${GRN}./launch.sh${RST}"
