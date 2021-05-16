class Urun {
  final String? urunID;
  String? adi;
  String? urunKodu;
  String? photoURL;
  String? aciklama1;
  String? aciklama2;
  String? tip1;
  String? tip2;
  int? adet;

  @override
  String toString() {
    return 'Urun{urunID: $urunID, adi: $adi, urunKodu: $urunKodu, photoURL: $photoURL, aciklama1: $aciklama1, aciklama2: $aciklama2, tip1: $tip1, tip2: $tip2}';
  }

  static Urun urunAdd({required Urun urun}) {
    Urun yeniUrun = Urun(
      urunID: urun.urunID,
      adi: urun.adi,
      urunKodu: urun.urunKodu,
      photoURL: urun.photoURL,
      aciklama1: urun.aciklama1,
      aciklama2: urun.aciklama2,
      tip1: urun.tip1,
      tip2: urun.tip2,
    );
    return yeniUrun;
  }

  Urun(
      {required this.urunID,
      this.adi,
      this.urunKodu,
      this.photoURL,
      this.aciklama1,
      this.aciklama2,
      this.tip1,
      this.tip2});

  Map<String, dynamic> toMap() {
    return {
      'urunID': urunID,
      'adi': adi,
      'urunKodu': urunKodu,
      'photoURL': photoURL,
      'aciklama1': aciklama1,
      'aciklama2': aciklama2,
      'tip1': tip1,
      'tip2': tip2,
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      'urunID': urunID,
      'adi': adi,
      'urunKodu': urunKodu,
      'photoURL': photoURL,
      'aciklama1': aciklama1,
      'aciklama2': aciklama2,
      'tip1': tip1,
      'tip2': tip2,
      'adet': adet,
    };
  }

  Urun.fromMap(Map<String, dynamic> map)
      : urunID = map['urunID'],
        adi = map['adi'],
        urunKodu = map['urunKodu'],
        photoURL = map['photoURL'],
        aciklama1 = map['aciklama1'],
        aciklama2 = map['aciklama2'],
        tip1 = map['tip1'],
        tip2 = map['tip2'];

  Urun.fromMap2(Map<String, dynamic> map)
      : urunID = map['urunID'],
        adi = map['adi'],
        urunKodu = map['urunKodu'],
        photoURL = map['photoURL'],
        aciklama1 = map['aciklama1'],
        aciklama2 = map['aciklama2'],
        tip1 = map['tip1'],
        tip2 = map['tip2'],
        adet = map['adet'];

/*
  UrunModel({this.name, this.kod, this.photoURL});

  static List<UrunModel> urunListModel = [
    UrunModel(
      name: "DEFNE EKSTRAKTLI SIVI SABUN 1000 ML.",
      kod: "362",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/362.png",
    ),
    UrunModel(
      name: "GREYFURT ÖZLÜ ŞAMPUAN 300 ML.",
      kod: "318",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/318.png",
    ),
    UrunModel(
      name: "VÜCUT BAKIM KREMİ 200 ML",
      kod: "237",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/237.jpg",
    ),
    UrunModel(
      name: "YAĞ ÇÖZÜCÜ 1000 ML.",
      kod: "114",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/114.png",
    ),
    UrunModel(
      name: "BULAŞIK SIVISI 1000 ML.",
      kod: "118",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/118.png",
    )
  ];w
  */
}
