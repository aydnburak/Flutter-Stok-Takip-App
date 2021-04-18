import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class HaberBulteniPage extends StatefulWidget {
  @override
  _HaberBulteniPageState createState() => _HaberBulteniPageState();
}

class _HaberBulteniPageState extends State<HaberBulteniPage> {
  @override
  Widget build(BuildContext context) {
    final _islemModel = Provider.of<IslemViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              print(_islemModel.user.toString());
              print("------");
              print(_islemModel.ustUser.toString());
            },
            child: Text("Bas"),
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
          Text("Bu Sayfa İçin Güncelleme Çok Yakında."),
        ],
      ),
    );
  }
}
