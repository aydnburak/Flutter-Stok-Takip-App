import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      drawer: drawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("ERSAĞ"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _userModel.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _categorilerBolumu(),
          _filtrelemeBolumu(),
          _listelemeBolumu(),
        ],
      ),
    );
  }

  _categorilerBolumu() {
    return Container(
      color: Colors.white54,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: CategoriesModel.categoriesModel.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: selectedIndex == index ? Colors.green : Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    selectedIndex != index
                        ? BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, -1))
                        : BoxShadow(),
                  ]),
              child: Center(
                  child: Text(
                CategoriesModel.categoriesModel[index].title!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index ? Colors.white : Colors.black54),
              )),
            ),
          );
        },
      ),
    );
  }

  drawerMenu() {
    return Drawer(
      child: Center(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _filtrelemeBolumu() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10, right: 20),
      child: Row(
        children: [
          Text(
            "Ürünlerimiz",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              print("filtrele basıldı");
            },
            child: Row(
              children: <Widget>[
                Text(
                  "filtrele",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 15,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _listelemeBolumu() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: UrunListModel.urunListModel.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) =>
              _urunCard(urunListModel: UrunListModel.urunListModel[index]),
        ),
      ),
    );
  }

  _urunCard({UrunListModel? urunListModel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Text("Kod:" + urunListModel!.kod!),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 5,
                    left: 0,
                    child: Hero(
                      tag: "${urunListModel.photoURL!}",
                      child: Image.network("${urunListModel.photoURL}"),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${urunListModel.name!}",
                style: TextStyle(
                  //color: DefaultElements.kprimarycolor,
                  //fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesModel {
  //String? image;
  String? title;

  CategoriesModel({this.title});

//CategoriesModel({this.image, this.title});

  static List<CategoriesModel> categoriesModel = [
    CategoriesModel(
      //image: "assets/icons/shoes.svg",
      title: "Temizlik",
    ),
    CategoriesModel(
      //image: "assets/icons/watch.svg",
      title: "Kozmetik",
    ),
    CategoriesModel(
      //image: "assets/icons/backpack.svg",
      title: "Gıda Takviyesi",
    ),
    CategoriesModel(
      //image: "assets/icons/backpack.svg",
      title: "Sabit Yağlar",
    ),
    CategoriesModel(
      //image: "assets/icons/backpack.svg",
      title: "Saklama Kapları",
    ),
    CategoriesModel(
      //image: "assets/icons/backpack.svg",
      title: "Ürün Destek",
    ),
  ];
}

class UrunListModel {
  String? name;
  String? kod;
  String? photoURL;

  UrunListModel({this.name, this.kod, this.photoURL});

  static List<UrunListModel> urunListModel = [
    UrunListModel(
      name: "DEFNE EKSTRAKTLI SIVI SABUN 1000 ML.",
      kod: "362",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/362.png",
    ),
    UrunListModel(
      name: "GREYFURT ÖZLÜ ŞAMPUAN 300 ML.",
      kod: "318",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/318.png",
    ),
    UrunListModel(
      name: "VÜCUT BAKIM KREMİ 200 ML",
      kod: "237",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/237.jpg",
    ),
    UrunListModel(
      name: "YAĞ ÇÖZÜCÜ 1000 ML.",
      kod: "114",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/114.png",
    ),
    UrunListModel(
      name: "BULAŞIK SIVISI 1000 ML.",
      kod: "118",
      photoURL: "https://dosya.ersag.com.tr/upload/image/products/118.png",
    )
  ];
}
