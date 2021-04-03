import 'package:flutter/material.dart';
import 'package:stok_app/Components/drawer_menu.dart';

class StokPage extends StatefulWidget {
  @override
  _StokPageState createState() => _StokPageState();
}

class _StokPageState extends State<StokPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("STOK"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Stok"),
      ),
    );
  }
}
