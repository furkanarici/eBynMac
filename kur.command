sudo mkdir ~/Desktop/eBeyanname
sudo chown -R $(whoami) ~/Desktop/eBeyanname

sudo mkdir /opt/ebyn 
sudo mkdir /opt/ebyn/download
sudo mkdir /opt/ebyn/update
sudo chown -R $(whoami) /opt/ebyn

sudo cp -R ~/Downloads/eBynMac-main/assets/files/bdp.command ~/Desktop/eBeyanname
sudo cp -R ~/Downloads/eBynMac-main/assets/files/paketler.command ~/Desktop/eBeyanname
sudo cp -R ~/Downloads/eBynMac-main/assets/files/LucaProxyKurulum.command ~/Desktop/eBeyanname
sudo cp -R ~/Downloads/eBynMac-main/assets/files/bdp.sh /opt/ebyn/update

sudo cp -R ~/Downloads/eBynMac-main/assets/files/EFaturaWebSocket.jnlp ~/Desktop/eBeyanname
sudo cp -R ~/Downloads/eBynMac-main/assets/files/KamuSMMaliMuhurUygulamasi.jnlp ~/Desktop/eBeyanname
sudo ln -fs ~/Downloads/eBynMac-main/assets/files/libakisp11.dylib /Library/Java/Extensions;

sudo cp -R ~/Downloads/eBynMac-main/assets/files/bdpGuncelleme.command ~/Desktop/eBeyanname
sh ~/Desktop/eBeyanname/bdpGuncelleme.command

cd /opt/ebyn/download

curl -O https://kamusm.bilgem.tubitak.gov.tr/islemler/surucu_yukleme_servisi/suruculer/AkisKart/macos/Akia_macos_1_8_0.zip

unzip Akia_macos_1_8_0.zip

sudo rm -R Akia_macos_1_8_0.zip

open akia_macos_1_8_0.dmg

sudo chown -R $(whoami) /opt/ebyn
open ~/Desktop/eBeyanname

sudo chmod +x ~/Desktop/eBeyanname/LucaProxyKurulum.command
sudo chmod +x ~/Desktop/eBeyanname/bdp.command
sudo chmod +x ~/Desktop/eBeyanname/bdpGuncelleme.command
sudo chmod +x ~/Desktop/eBeyanname/paketler.command