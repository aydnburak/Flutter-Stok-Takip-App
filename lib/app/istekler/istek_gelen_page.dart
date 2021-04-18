import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/islem_card.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class IstekGelenPage extends StatefulWidget {
  @override
  _IstekGelenPageState createState() => _IstekGelenPageState();
}

class _IstekGelenPageState extends State<IstekGelenPage> {
  @override
  void initState() {
    print("istek Gelen Page Açıldı");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _islemModel = Provider.of<IslemViewModel>(context);

    if (_islemModel.isteklerGeldimi) {
      return ListView.builder(
          itemCount: _islemModel.gelenIslemlerim.length,
          itemBuilder: (context, index) => IslemCard(
              sepet: _islemModel.gelenIslemlerim[index], index: index, durum: false));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
