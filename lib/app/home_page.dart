import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/drawer_menu.dart';
import 'package:stok_app/Components/urun_card.dart';
import 'package:stok_app/models/categories_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("ERSAĞ"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _categorilerBolumu(),
          _filtrelemeBolumu(),
          _filterBaslikBolumu(),
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
              setState(() {
                if (value.toString() == "TÜMÜ") {
                  selectedFilter = null;
                } else {
                  selectedFilter = value.toString();
                }
              });
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
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: UrunModel.urunListModel.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => UrunCard(urunModel: UrunModel.urunListModel[index]),
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
}