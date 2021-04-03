class CategoriesModel {
  //String? image;
  String? title;
  List<String?>? filterList = [];

  CategoriesModel({this.title, this.filterList});

//CategoriesModel({this.image, this.title});

  static List<CategoriesModel> categoriesModel = [
    CategoriesModel(
      //image: "assets/icons/shoes.svg",
      title: "Temizlik",
      filterList: [
        "TÜMÜ",
        "ÇAMAŞIR TEMİZLİĞİ",
        "MUTFAK TEMİZLİĞİ",
        "GENEL EV TEMİZLİĞİ",
        "KİŞİSEL TEMİZLİK",
        "SPREYLER",
      ],
    ),
    CategoriesModel(
      //image: "assets/icons/watch.svg",
      title: "Kozmetik",
      filterList: [
        "TÜMÜ",
        "RENKLİ KOZMETİK",
        "JÖLELER",
        "PARFÜM & ROLL-ON",
        "LOSYONLAR",
        "BAKIM ÜRÜNLERİ",
      ],
    ),
    CategoriesModel(
      //image: "assets/icons/backpack.svg",
      title: "Gıda Takviyesi",
      filterList: [
        "TÜMÜ",
        "VİTAMİN GRUBUMUZ",
        "İÇECEK GRUBUMUZ",
        "ARI ÜRÜNLERİMİZ",
        "BİTKİSEL YAĞLAR",
        "TAKVİYE EDİCİ GIDALAR",
      ],
    ),
    CategoriesModel(
      //image: "assets/icons/backpack.svg",
      title: "Sabit Yağlar",
      filterList: [
        "TÜMÜ",
      ],
    ),
    CategoriesModel(
      //image: "assets/icons/backpack.svg",
      title: "Saklama Kapları",
      filterList: [
        "TÜMÜ",
      ],
    ),
    CategoriesModel(
      //image: "assets/icons/backpack.svg",
      title: "Ürün Destek",
      filterList: [
        "TÜMÜ",
      ],
    ),
  ];
}
