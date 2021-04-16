import 'package:flutter/material.dart';
import 'package:stok_app/Components/drawer_menu.dart';
import 'package:stok_app/app/istekler/istek_gelen_page.dart';
import 'package:stok_app/app/istekler/istek_kendim_page.dart';

class TabbarPage extends StatefulWidget {
  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  @override
  void initState() {
    print("Tabbar dayız");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        drawer: DrawerMenu(),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          title: Text("ISTEKLER"),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Kendim"),
              Tab(text: "Gelen"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            IstekKendimPage(),
            IstekGelenPage(),
          ],
        ),
      ),
    );
  }
}
