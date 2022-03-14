cd ~/Desktop/'Java Uygulamalar'/Guncelleme/download
sudo mkdir /opt/ebyn 
sudo chown -R $(whoami) /opt/ebyn
sudo cp -R ~/Desktop/'Java Uygulamalar'/Guncelleme/download/ebyn_pardus/* /opt/ebyn;
sudo cp -R ~/Desktop/'Java Uygulamalar'/Guncelleme/bdp.sh /opt/ebyn;
sudo cp -R ~/Desktop/'Java Uygulamalar'/Guncelleme/bdp_bg.jpg /opt/ebyn;

rm -R ~/Desktop/'Java Uygulamalar'/Guncelleme/download
mkdir ~/Desktop/'Java Uygulamalar'/Guncelleme/download
