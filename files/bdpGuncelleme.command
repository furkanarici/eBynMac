rm -R ~/Desktop/eBeyanname/Guncelleme/download
mkdir ~/Desktop/eBeyanname/Guncelleme/download

cd ~/Desktop/eBeyanname/Guncelleme/download
curl -O https://ebeyanname.gib.gov.tr/ebyn_pardus.tar.gz
unzip ebyn_pardus.tar.gz

cd ~/Desktop/eBeyanname/Guncelleme/download
sudo mkdir /opt/ebyn 
sudo chown -R $(whoami) /opt/ebyn
sudo cp -R ~/Desktop/eBeyanname/Guncelleme/download/ebyn_pardus/* /opt/ebyn;
sudo cp -R ~/Desktop/eBeyanname/Guncelleme/bdp.sh /opt/ebyn;
sudo cp -R ~/Desktop/eBeyanname/Guncelleme/bdp_bg.jpg /opt/ebyn;

rm -R ~/Desktop/eBeyanname/Guncelleme/download
mkdir ~/Desktop/eBeyanname/Guncelleme/download
