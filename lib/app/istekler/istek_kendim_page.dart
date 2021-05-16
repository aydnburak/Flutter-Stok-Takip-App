import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/islem_card.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class IstekKendimPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("istek Kendim Page Açıldı");
    final _islemModel = Provider.of<IslemViewModel>(context);

    if (_islemModel.isteklerGeldimi) {
      return RefreshIndicator(
        onRefresh: () async {
          final _islemModel = Provider.of<IslemViewModel>(context, listen: false);
          await _islemModel.getIsteklerim();
        },
        child: ListView.builder(
            itemCount: _islemModel.myIslemlerim.length,
            itemBuilder: (context, index) => IslemCard(
                sepet: _islemModel.myIslemlerim[index], index: index, durum: true)),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          final _islemModel = Provider.of<IslemViewModel>(context, listen: false);
          await _islemModel.getIsteklerim();
        },
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
