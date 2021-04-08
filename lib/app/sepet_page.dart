import 'package:flutter/material.dart';
import 'package:stok_app/Components/drawer_menu.dart';

class SepetPage extends StatefulWidget {
  @override
  _SepetPageState createState() => _SepetPageState();
}

class _SepetPageState extends State<SepetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("SEPET"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
