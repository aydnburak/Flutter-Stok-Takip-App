import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/drawer_menu.dart';
import 'package:stok_app/app/istekler/istek_gelen_page.dart';
import 'package:stok_app/app/istekler/istek_kendim_page.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class TabbarPage extends StatefulWidget {
  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  @override
  void initState() {
    print("Tabbar dayız");
    final _islemModel = Provider.of<IslemViewModel>(context, listen: false);
    _islemModel.getIslemlerim();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerMenu(),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          title: Text("İSTEKLER"),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "İsteklerim"),
              Tab(text: "Gelen İsteklerim"),
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
