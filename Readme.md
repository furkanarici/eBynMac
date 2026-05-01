# eBeyanname

macOS uygulaması — Gelir İdaresi Başkanlığı eBeyanname (BDP) programını Mac'te kolayca kurun ve çalıştırın.

## Gereksinimler

- macOS 13 Ventura veya üzeri
- Apple Silicon veya Intel Mac

## Kurulum

1. [Releases](https://github.com/furkanarici/eBynMac/releases) sayfasından son DMG dosyasını indirin
2. DMG'yi açın ve uygulamayı Applications klasörüne sürükleyin
3. Uygulamayı başlatın — kurulum sihirbazı gerekli bileşenleri adım adım yükler

Uygulama şunları yönetir:
- Java (GİB gereksinimi)
- Akia PKCS#11 sürücüsü (mali mühür — isteğe bağlı)
- BDP uygulama dosyaları (GİB sunucusundan indirilir)
- Luca Proxy (isteğe bağlı)

## Geliştirme

### Gereksinimler

- Xcode 15+
- Swift 5.9+

### Yerel derleme ve çalıştırma

```bash
make dev
```

Bu komut uygulamayı derler, `.app` paketini oluşturur ve doğrudan açar.

### Diğer komutlar

```bash
make build      # Release derlemesi (universal binary)
make sign       # Developer ID ile imzalama
make notarize   # Apple notarizasyonu
make dmg        # Dağıtım DMG'si oluşturma
make release    # Tam pipeline: build → sign → notarize → dmg
```

## Güncelleme

Uygulama Sparkle aracılığıyla kendini otomatik günceller. BDP dosyaları için uygulama içindeki "Güncellemeler" butonunu kullanın.

---

© 2026 [furkanarici.com](https://furkanarici.com)
