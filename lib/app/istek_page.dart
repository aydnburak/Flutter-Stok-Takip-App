import 'package:flutter/material.dart';
import 'package:stok_app/Components/drawer_menu.dart';

class IstekPage extends StatefulWidget {
  @override
  _IstekPageState createState() => _IstekPageState();
}

class _IstekPageState extends State<IstekPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("ISTEKLER"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("İstekler"),
      ),
    );
  }
}
