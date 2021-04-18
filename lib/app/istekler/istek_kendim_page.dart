import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/islem_card.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class IstekKendimPage extends StatefulWidget {
  @override
  _IstekKendimPageState createState() => _IstekKendimPageState();
}

class _IstekKendimPageState extends State<IstekKendimPage> {
  @override
  void initState() {
    print("istek Kendim Page Açıldı");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _islemModel = Provider.of<IslemViewModel>(context);

    if (_islemModel.isteklerGeldimi) {
      return ListView.builder(
          itemCount: _islemModel.myIslemlerim.length,
          itemBuilder: (context, index) => IslemCard(
              sepet: _islemModel.myIslemlerim[index], index: index, durum: true));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
