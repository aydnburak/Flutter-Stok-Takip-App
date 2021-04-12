import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/drawer_menu.dart';
import 'package:stok_app/Components/urun_card.dart';
import 'package:stok_app/models/categories_model.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String? selectedAnaTip = "TEMİZLİK GRUBU";
  String? selectedFilter;

  @override
  void initState() {
    final _urunModel = Provider.of<UrunViewModel>(context, listen: false);
    print("home page acıldı ");
    if (!_urunModel.homeOpen) {
      _urunModel.homeOpen = true;
      _urunModel.getFavoriler();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _urunModel = Provider.of<UrunViewModel>(context);
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("ERSAĞ"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_basket_outlined),
            onPressed: () {
              setState(() {});
              /*
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SepetPage(),
                ),
              );
               */
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _categorilerBolumu(),
          _filtrelemeBolumu(),
          _filterBaslikBolumu(),
          _urunModel.state == UrunState.Idle
              ? _urunModel.urunler.isNotEmpty
                  ? _listelemeBolumu()
                  : _kullaniciYokUI()
              : Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }

  _categorilerBolumu() {
    final _urunModel = Provider.of<UrunViewModel>(context);
    return Container(
      color: Colors.white54,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: CategoriesModel.categoriesModel.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectedIndex = index;
              selectedAnaTip = CategoriesModel.anaTip[index];
              selectedFilter = null;
              _urunModel.getUrunler(selectedAnaTip, selectedFilter);
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

  _filtrelemeBolumu() {
    final _urunModel = Provider.of<UrunViewModel>(context);
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
          PopupMenuButton(
            itemBuilder: (context) {
              return CategoriesModel.categoriesModel[selectedIndex].filterList!
                  .map((filtre) => PopupMenuItem(
                        child: Text(filtre!),
                        value: filtre,
                      ))
                  .toList();
            },
            onSelected: (value) {
              if (value.toString() == "TÜMÜ") {
                selectedFilter = null;
              } else {
                selectedFilter = value.toString();
              }
              _urunModel.getUrunler(selectedAnaTip, selectedFilter);
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
                  //size: 15,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _listelemeBolumu() {
    final _urunModel = Provider.of<UrunViewModel>(context);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: _urunModel.urunler.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => UrunCard(urunModel: _urunModel.urunler[index]),
        ),
      ),
    );
  }

  _filterBaslikBolumu() {
    return selectedFilter != null
        ? Padding(
            padding: EdgeInsets.only(left: 10, top: 10, right: 20),
            child: Row(
              children: <Widget>[
                Text(
                  selectedFilter!,
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _kullaniciYokUI() {
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
