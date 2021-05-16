import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/urun_model.dart';
import '../viewmodel/islem_viewmodel.dart';

class SepetUrunCard extends StatelessWidget {
  final Urun urun;

  SepetUrunCard({required this.urun});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                child: ExtendedImage.network(
                  urun.photoURL!,
                  cache: true,
                ),
              )),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    AutoSizeText(
                      urun.tip1! + "/" + urun.tip2! + "/",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 10),
                      minFontSize: 8,
                    ),
                    Spacer(),
                  ],
                ),
                AutoSizeText(
                  urun.adi!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('adet tıklandı');
                        _adetModalBottomSheet(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Text("Adet: " + urun.adet.toString(),
                                style: TextStyle(fontSize: 15)),
                            Icon(Icons.expand_more),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _sepetUrunSil(context);
                        }),
                  ],
                ),
                // AddRemoveButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _adetModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView(
            itemExtent: 50,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Adet Seçiniz",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    CloseButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              ListTile(
                  title: Text("1"),
                  onTap: () {
                    _adetGuncelle(context, 1);
                  }),
              ListTile(
                  title: Text("2"),
                  onTap: () {
                    _adetGuncelle(context, 2);
                  }),
              ListTile(
                  title: Text("3"),
                  onTap: () {
                    _adetGuncelle(context, 3);
                  }),
              ListTile(
                  title: Text("4"),
                  onTap: () {
                    _adetGuncelle(context, 4);
                  }),
              ListTile(
                  title: Text("5"),
                  onTap: () {
                    _adetGuncelle(context, 5);
                  }),
              ListTile(
                  title: Text("6"),
                  onTap: () {
                    _adetGuncelle(context, 6);
                  }),
              ListTile(
                  title: Text("7"),
                  onTap: () {
                    _adetGuncelle(context, 7);
                  }),
              ListTile(
                  title: Text("8"),
                  onTap: () {
                    _adetGuncelle(context, 8);
                  }),
              ListTile(
                  title: Text("9"),
                  onTap: () {
                    _adetGuncelle(context, 9);
                  }),
              ListTile(
                  title: Text("10"),
                  onTap: () {
                    _adetGuncelle(context, 10);
                  }),
            ],
          ),
        );
      },
    );
  }

  void _adetGuncelle(BuildContext context, int adet) {
    final _islemModel = Provider.of<IslemViewModel>(context, listen: false);
    _islemModel.sepetUrunAdetGuncelle(urun.urunID!, adet);
    Navigator.pop(context);
  }

  void _sepetUrunSil(BuildContext context) {
    final _islemModel = Provider.of<IslemViewModel>(context, listen: false);
    _islemModel.sepetUrunSil(urun.urunID!);
  }
}
