sudo mkdir ~/Desktop/eBeyanname/
sudo mkdir ~/Desktop/eBeyanname/Guncelleme/
sudo mkdir ~/Desktop/eBeyanname/Guncelleme/download
sudo chown -R $(whoami) ~/Desktop/eBeyanname

sudo mkdir /opt/ebyn 
sudo chown -R $(whoami) /opt/ebyn

sudo cp -R ~/Downloads/eBynMac-main/files/bdp_bg.jpg ~/Desktop/eBeyanname/Guncelleme
sudo cp -R ~/Downloads/eBynMac-main/files/bdp.sh ~/Desktop/eBeyanname/Guncelleme
sudo cp -R ~/Downloads/eBynMac-main/files/bdpGuncelleme.command ~/Desktop/eBeyanname
sudo cp -R ~/Downloads/eBynMac-main/files/bdp.command ~/Desktop/eBeyanname

sudo cp -R ~/Downloads/eBynMac-main/files/EFaturaWebSocket.jnlp ~/Desktop/eBeyanname
sudo cp -R ~/Downloads/eBynMac-main/files/KamuSMMaliMuhurUygulamasi.jnlp ~/Desktop/eBeyanname
sudo cp -R ~/Downloads/eBynMac-main/files/paketler.command ~/Desktop/eBeyanname

sudo ln -s ~/Downloads/eBynMac-main/files/libakisp11.dylib /Library/Java/Extensions;

cd ~/Desktop/eBeyanname/Guncelleme/download
curl -O https://ebeyanname.gib.gov.tr/ebyn_pardus.tar.gz

unzip ebyn_pardus.tar.gz

sudo cp -R ~/Desktop/eBeyanname/Guncelleme/download/ebyn_pardus/* /opt/ebyn;
sudo cp -R ~/Desktop/eBeyanname/Guncelleme/bdp.sh /opt/ebyn;
sudo cp -R ~/Desktop/eBeyanname/Guncelleme/bdp_bg.jpg /opt/ebyn;

open ~/Desktop/eBeyanname




