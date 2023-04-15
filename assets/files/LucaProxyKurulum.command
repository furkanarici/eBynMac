#!/bin/bash

cd ~/Downloads && rm LucaProxyKurulumMac.sh

# LucaProxyKurulumMac.sh dosyasını indir
curl -O https://auygs.luca.com.tr/Luca/yardim/uygulamalar/LucaProxyKurulumMac.sh

# indirme tamamlandığında downloads klasörüne git ve dosyayı çalıştır
cd ~/Downloads && bash LucaProxyKurulumMac.sh

# yükleme tamamlandıktan sonra LucaProxyKurulumMac.sh dosyasını sil
cd ~/Downloads && rm LucaProxyKurulumMac.sh