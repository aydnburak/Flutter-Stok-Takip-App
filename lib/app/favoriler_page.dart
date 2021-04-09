import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/drawer_menu.dart';
import 'package:stok_app/Components/urun_card.dart';
import 'package:stok_app/models/categories_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class FavorilerPage extends StatefulWidget {
  @override
  _FavorilerPageState createState() => _FavorilerPageState();
}

class _FavorilerPageState extends State<FavorilerPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("FAVORiLER"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _categorilerBolumu(),
          _baslikBolumu(),
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
        itemCount: CategoriesModel.categoriesModel2.length,
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
                        ? BoxShadow(
                            color: Colors.grey, blurRadius: 10, offset: Offset(0, -1))
                        : BoxShadow(),
                  ]),
              child: Center(
                  child: Text(
                CategoriesModel.categoriesModel2[index].title!,
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

  _baslikBolumu() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            "Favori Ürünleriniz",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  _listelemeBolumu() {
    final _urunModel = Provider.of<UrunViewModel>(context);
    List<Urun> _favoriler = _favorileriVer(_urunModel.favoriUrunler);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: _favoriler.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => UrunCard(urunModel: _favoriler[index]),
        ),
      ),
    );
  }

  List<Urun> _favorileriVer(List<Urun> favoriUrunler) {
    List<Urun> donecekFavoriler = [];

    if (selectedIndex != 0) {
      for (Urun urun in favoriUrunler) {
        if (urun.tip1 == CategoriesModel.anaTip[selectedIndex - 1]) {
          donecekFavoriler.add(urun);
        }
      }

      return donecekFavoriler;
    } else {
      return favoriUrunler;
    }
  }
}
