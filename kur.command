#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ASSETS_DIR="$SCRIPT_DIR/assets"

# Create necessary directories
sudo mkdir -p ~/Desktop/eBeyanname
sudo chown -R $(whoami) ~/Desktop/eBeyanname

sudo mkdir -p /opt/ebyn
sudo mkdir -p /opt/ebyn/download
sudo mkdir -p /opt/ebyn/update
sudo chown -R $(whoami) /opt/ebyn

# Copy files from assets folder to destination
sudo cp -R "$ASSETS_DIR/files/bdp.command" ~/Desktop/eBeyanname
sudo cp -R "$ASSETS_DIR/files/paketler.command" ~/Desktop/eBeyanname
sudo cp -R "$ASSETS_DIR/files/LucaProxyKurulum.command" ~/Desktop/eBeyanname
sudo cp -R "$ASSETS_DIR/files/bdp.sh" /opt/ebyn/update

sudo cp -R "$ASSETS_DIR/files/EFaturaWebSocket.jnlp" ~/Desktop/eBeyanname
sudo cp -R "$ASSETS_DIR/files/KamuSMMaliMuhurUygulamasi.jnlp" ~/Desktop/eBeyanname
sudo ln -fs "$ASSETS_DIR/files/libakisp11.dylib" /Library/Java/Extensions

sudo cp -R "$ASSETS_DIR/files/bdpGuncelleme.command" ~/Desktop/eBeyanname
sh ~/Desktop/eBeyanname/bdpGuncelleme.command

# Download and install Akia driver
cd /opt/ebyn/download

curl -O https://kamusm.bilgem.tubitak.gov.tr/islemler/surucu_yukleme_servisi/suruculer/AkisKart/macos/Akia_macos_1_8_0.zip

unzip Akia_macos_1_8_0.zip

sudo rm -R Akia_macos_1_8_0.zip

open akia_macos_1_8_0.dmg

# Set permissions and open directory
sudo chown -R $(whoami) /opt/ebyn
open ~/Desktop/eBeyanname

sudo chmod +x ~/Desktop/eBeyanname/LucaProxyKurulum.command
sudo chmod +x ~/Desktop/eBeyanname/bdp.command
sudo chmod +x ~/Desktop/eBeyanname/bdpGuncelleme.command
sudo chmod +x ~/Desktop/eBeyanname/paketler.command