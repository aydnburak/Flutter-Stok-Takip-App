import 'package:flutter/material.dart';
import 'package:stok_app/Components/drawer_menu.dart';

class FavorilerPage extends StatefulWidget {
  @override
  _FavorilerPageState createState() => _FavorilerPageState();
}

class _FavorilerPageState extends State<FavorilerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("FAVORiLER"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Favoriler"),
      ),
    );
  }
}
