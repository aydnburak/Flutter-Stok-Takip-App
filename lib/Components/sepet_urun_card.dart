import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class SepetUrunCard extends StatefulWidget {
  final Urun urun;
  final int index;

  SepetUrunCard({required this.urun, required this.index});

  @override
  _SepetUrunCardState createState() => _SepetUrunCardState();
}

class _SepetUrunCardState extends State<SepetUrunCard> {
  late Urun urun;
  late int adet;

  @override
  void initState() {
    urun = widget.urun;
    adet = widget.urun.adet!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("urun karta tıklandı");
        /*
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetayScreen(
              urun: urunModel,
              fav: _fav,
            ),
          ),
        );
         */
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
        margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)
          ],
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
                          _adetModalBottomSheet();
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: <Widget>[
                              Text("Adet: " + adet.toString(),
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
                            _sepetUrunSil();
                          }),
                    ],
                  ),
                  // AddRemoveButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _adetModalBottomSheet() {
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
                    adet = 1;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("2"),
                  onTap: () {
                    adet = 2;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("3"),
                  onTap: () {
                    adet = 3;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("4"),
                  onTap: () {
                    adet = 4;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("5"),
                  onTap: () {
                    adet = 5;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("6"),
                  onTap: () {
                    adet = 6;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("7"),
                  onTap: () {
                    adet = 7;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("8"),
                  onTap: () {
                    adet = 8;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("9"),
                  onTap: () {
                    adet = 9;
                    _adetGuncelle();
                  }),
              ListTile(
                  title: Text("10"),
                  onTap: () {
                    adet = 10;
                    _adetGuncelle();
                  }),
            ],
          ),
        );
      },
    );
  }

  void _adetGuncelle() {
    final _islemModel = Provider.of<IslemViewModel>(context, listen: false);
    _islemModel.sepetUrunAdetGuncelle(urun.urunID!, adet);
    Navigator.pop(context);
    setState(() {});
  }

  void _sepetUrunSil() {
    final _islemModel = Provider.of<IslemViewModel>(context, listen: false);
    _islemModel.sepetUrunSil(urun.urunID!);
  }
}
