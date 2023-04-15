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

curl -O https://download.oracle.com/java/17/latest/jdk-17_macos-aarch64_bin.dmg
curl -O https://download.oracle.com/java/17/latest/jdk-17_macos-x64_bin.dmg
curl -O https://kamusm.bilgem.tubitak.gov.tr/islemler/surucu_yukleme_servisi/suruculer/AkisKart/macos/Akia_macos_1_8_0.zip
curl -L "https://drive.google.com/u/0/uc?id=1wPutXX40gJJevRRwnOuL2blzJt9e0dRx&export=download&confirm=t" > java.zip


unzip Akia_macos_1_8_0.zip
unzip java.zip

sudo cp -R /opt/ebyn/download/java/* /opt/ebyn/download;
sudo rm -R /opt/ebyn/download/java
sudo rm -R Akia_macos_1_8_0.zip
sudo rm -R java.zip

open akia_macos_1_8_0.dmg
open jdk-17_macos-x64_bin.dmg
open jdk-17_macos-aarch64_bin.dmg

open jdk-7u80-macosx-x64.dmg
open jre-8u321-macosx-x64.dmg

sudo chown -R $(whoami) /opt/ebyn
open ~/Desktop/eBeyanname

chmod +x ~/Desktop/eBeyanname/LucaProxyKurulum.command