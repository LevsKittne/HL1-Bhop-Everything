# HL1-Bhop-Everything — GoldSrc / Half-Life 1 bunnyhop hareketi

[English / Languages / 多语言 / Языки](README.md) · **Türkçe**

Değiştirilebilir 3D oyunlara yapay zekâ kodlama asistanıyla bunnyhop (bhop), otomatik zıplama ve havada hızlanma ekleme kılavuzu. Unity, Unreal Engine ve Godot yönergeleri; C++, C# ve GDScript örnekleri ile ortak testler içerir.

## Başlangıç

Depoyu indirin, dosyaları okuyup düzenleyebilen bir asistanda açın ve <YOL> alanını gerçek oyun veya proje yoluyla değiştirin.

[İngilizce adım adım kılavuz](docs/START-HERE.en.md)

```text
AGENTS.md ve docs/START-HERE.en.md dosyalarını oku.
<YOL> konumundaki oyun/projeye classic-bhop, zıplama tuşunu basılı tutunca
otomatik zıplama ve okunaklı yatay UPS göstergesi ekle.
Önce motoru, birim dönüşümünü, hızı yazan kodu ve hareket yetkisini belirle.
Mevcut denetleyiciye entegre et; normal zıplama yüksekliğini, çarpışmaları,
eğilme için boşluk kontrolünü ve tuşları koru. Motor kılavuzunu Türkçeye çevir.
Uygula, derle, test et; kurulum, geri alma ve gerçek test sonuçlarını ver.
Çalıştırılamayan testleri açıkça belirt; yalnızca sözde kodla bitirme.
```

Kaynak koduna, mod API’sine veya doğrulanmış bir genişletme noktasına erişim gerekir. Bu, her oyuna doğrudan kurulabilen evrensel bir yama değildir. Çok oyunculu oyunda sunucu simülasyonu ile istemci tahmini aynı hareket kurallarını kullanmalıdır.

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## Çeviri kapsamı

Bu giriş ve yapay zekâ istemi Türkçedir. İngilizce adım adım kılavuz vardır; ayrıntılı motor belgeleri çoğunlukla Rusçadır. Formülleri, birimleri ve test gereksinimlerini koruyarak çeviri isteyin. Gerçekte yapılan doğrulamaları VALIDATION.md dosyasında bulabilirsiniz.

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
