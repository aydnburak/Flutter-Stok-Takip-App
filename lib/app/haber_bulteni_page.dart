import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stok_app/Components/drawer_menu.dart';

class HaberBulteniPage extends StatefulWidget {
  @override
  _HaberBulteniPageState createState() => _HaberBulteniPageState();
}

class _HaberBulteniPageState extends State<HaberBulteniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 50),
          AutoSizeText(
            "Bu Sayfa İçin Güncelleme Çok Yakında.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ],
      ),
    );
  }
}
