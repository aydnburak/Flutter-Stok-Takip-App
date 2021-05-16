import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/islem_card.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class IstekGelenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("istek Gelen Page Açıldı");
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
