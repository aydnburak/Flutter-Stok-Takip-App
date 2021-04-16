import 'package:flutter/material.dart';

class HaberBulteniPage extends StatefulWidget {
  @override
  _HaberBulteniPageState createState() => _HaberBulteniPageState();
}

class _HaberBulteniPageState extends State<HaberBulteniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
          Text("Bu Sayfa İçin Güncelleme Çok Yakında."),
        ],
      ),
    );
  }
}
