sudo mkdir ~/Desktop/eBeyanname/
sudo mkdir ~/Desktop/eBeyanname/Guncelleme/
sudo mkdir ~/Desktop/eBeyanname/Guncelleme/download
sudo chown -R $(whoami) ~/Desktop/eBeyanname

sudo mkdir /opt/ebyn 
sudo chown -R $(whoami) /opt/ebyn

cd ~/Desktop/eBeyanname/Guncelleme/download

https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245798_df5ad55fdd604472a86a45a217032c7d

sudo cp -R ~/Downloads/eBynMac/app/* ~/Desktop/eBeyanname/Guncelleme/download;
curl -O https://drive.google.com/uc?export=download&id=1eEBoAPSSre9vepaJCnlwAXktmBo1AS24
curl -O https://drive.google.com/uc?export=download&id=13Wr9BpXX6a1wcKNELwIeUdqJyBTgvt-e


curl -O https://download.oracle.com/java/17/latest/jdk-17_macos-aarch64_bin.dmg
curl -O https://download.oracle.com/java/17/latest/jdk-17_macos-x64_bin.dmg

curl -O https://kamusm.bilgem.tubitak.gov.tr/islemler/surucu_yukleme_servisi/suruculer/AkisKart/macos/Akia_macos_1_8_0.zip

curl -O https://ebeyanname.gib.gov.tr/ebyn_pardus.tar.gz

unzip Akia_macos_1_8_0.zip
unzip ebyn_pardus.tar.gz

open akia_macos_1_8_0.dmg
open jdk-7u80-macosx-x64.dmg
open jre-8u321-macosx-x64.dmg
open jdk-17_macos-x64_bin.dmg
open jdk-17_macos-aarch64_bin.dmg

sudo cp -R ~/Desktop/eBeyanname/Guncelleme/download/ebyn_pardus/* /opt/ebyn;

sudo cp -R ~/Desktop/'Java Uygulamalar'/Guncelleme/bdp.sh /opt/ebyn;
sudo cp -R ~/Desktop/'Java Uygulamalar'/Guncelleme/bdp_bg.jpg /opt/ebyn;

