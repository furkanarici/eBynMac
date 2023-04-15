#!/bin/bash

rm ~/Downloads/LucaProxyKurulumMac.sh
rm -rf ~/LucaProxy/*

# LucaProxyKurulumMac.sh dosyasını indir
cd ~/Downloads && curl -O https://auygs.luca.com.tr/Luca/yardim/uygulamalar/LucaProxyKurulumMac.sh

# indirme tamamlandığında downloads klasörüne git ve dosyayı çalıştır
bash ~/Downloads/LucaProxyKurulumMac.sh

open ~/LucaProxy
ln -s ~/LucaProxy/LucaProxy.jar ~/Desktop/LucaProxy