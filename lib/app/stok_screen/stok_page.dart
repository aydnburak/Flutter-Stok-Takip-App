import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/drawer_menu.dart';
import 'package:stok_app/app/stok_screen/components/depo_urun_card.dart';
import 'package:stok_app/models/categories_model.dart';
import 'package:stok_app/models/depo_urun_list_model.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class StokPage extends StatefulWidget {
  @override
  _StokPageState createState() => _StokPageState();
}

class _StokPageState extends State<StokPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    final _urunModel = Provider.of<UrunViewModel>(context, listen: false);
    if (!_urunModel.depoOpen) {
      _urunModel.depoOpen = true;
      _urunModel.getDepo1();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("STOK"),
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
                        ? BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, -1))
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
            "Depondaki Ürünler",
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
    List<DepoUrunList> _depoUrunList = _depoyuVer(_urunModel.depoUrunList);
    if (_depoUrunList.isNotEmpty) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: _depoUrunList.length,
            itemBuilder: (context, index) => DepoUrunCard(depoUrunList: _depoUrunList[index]),
          ),
        ),
      );
    } else {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.hourglass_empty,
                color: Theme.of(context).primaryColor,
                size: 120,
              ),
              Text(
                "Ürün Yok",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36),
              )
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.5,
      );
    }
  }

  List<DepoUrunList> _depoyuVer(List<DepoUrunList> depoUrunler) {
    List<DepoUrunList> donecekDepo = [];

    if (selectedIndex != 0) {
      for (DepoUrunList depoUrun in depoUrunler) {
        if (depoUrun.depoUrun.tip1 == CategoriesModel.anaTip[selectedIndex - 1]) {
          donecekDepo.add(depoUrun);
        }
      }

      return donecekDepo;
    } else {
      return depoUrunler;
    }
  }
}
