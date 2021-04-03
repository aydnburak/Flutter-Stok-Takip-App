class UrunModel {
  String? name;
  String? kod;
  String? photoURL;

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
  ];
}
