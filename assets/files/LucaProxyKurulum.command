#!/bin/bash

cd ~/Downloads && rm LucaProxyKurulumMac.sh

# LucaProxyKurulumMac.sh dosyasını indir
curl -O https://auygs.luca.com.tr/Luca/yardim/uygulamalar/LucaProxyKurulumMac.sh

# indirme tamamlandığında downloads klasörüne git ve dosyayı çalıştır
bash ~/Downloads/LucaProxyKurulumMac.sh

open ~/LucaProxy
ln -s ~/LucaProxy/LucaProxy.jar ~/Desktop/LucaProxy