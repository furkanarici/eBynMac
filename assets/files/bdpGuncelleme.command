sudo mkdir /opt/ebyn 
sudo chown -R $(whoami) /opt/ebyn

sudo rm -R /opt/ebyn/download
mkdir /opt/ebyn/download

sudo mkdir ~/Desktop/eBeyanname/
sudo chown -R $(whoami) ~/Desktop/eBeyanname


cd /opt/ebyn/download

curl -O https://dijital.gib.gov.tr/gerekliProgramlar#:~:text=ebyn_pardus.tar.gz
mkdir /opt/ebyn/download/ebyn_pardus
cd /opt/ebyn/download/ebyn_pardus
sudo cp -R /opt/ebyn/download/ebyn_pardus.tar.gz /opt/ebyn/download/ebyn_pardus
tar -xzf ebyn_pardus.tar.gz

cd /opt/ebyn/download

sudo cp -R /opt/ebyn/download/ebyn_pardus/* /opt/ebyn;

sudo cp -R /opt/ebyn/update/bdp.sh /opt/ebyn
cd /opt/ebyn;
sudo curl -O https://furkanarici.com/Tools/img/bdp_bg.jpg

sudo rm -R /opt/ebyn/download
mkdir /opt/ebyn/download

sudo chown -R $(whoami) /opt/ebyn