import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/istekler/tabbar.dart';
import 'package:stok_app/models/sepet_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class IstekDetayPage extends StatefulWidget {
  final Sepet sepet;
  final int index;
  final bool durum;

  IstekDetayPage({required this.sepet, required this.index, required this.durum});

  @override
  _IstekDetayPageState createState() => _IstekDetayPageState();
}

class _IstekDetayPageState extends State<IstekDetayPage> {
  late Sepet sepet;

  @override
  void initState() {
    sepet = widget.sepet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _islemModel = Provider.of<IslemViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("İstek Detayları", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Dikkat!"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("İstegi bir daha Göremeyeceksiniz!"),
                              Text("Silmek istediginizden Eminmisiniz?"),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Hayır")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  toastMesaj("İstek Silindi.");
                                  if (widget.durum) {
                                    _islemModel.myIslemlerim.removeAt(widget.index);
                                    _islemModel.islemSepetDelete(sepet.sepetID!);
                                  } else {
                                    _islemModel.gelenIslemlerim.removeAt(widget.index);
                                    _islemModel.islemSepetDelete(sepet.sepetID!);
                                  }
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TabbarPage(),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: Text("Evet")),
                          ],
                        ));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
              margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AutoSizeText(_tarihVeSaatiVer(sepet.createdAt!)),
                          SizedBox(height: 10),
                          widget.durum == true
                              ? AutoSizeText("Yetkili: " + sepet.ustUserName!)
                              : AutoSizeText("Kimden: " + sepet.userName!),
                        ],
                      ),
                      widget.durum == true ? Spacer() : _islemButton(widget.index, sepet),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  AutoSizeText(
                      _durumMesaji(sepet.onay!, sepet.tamamlandi!, widget.durum)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
              margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)
                ],
              ),
              child: Column(
                children: sepet.urunlerim!
                    .map(
                      (urun) => _istekDetayUrunCard(urun),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toastMesaj(String mesaj) {
    Fluttertoast.showToast(
      backgroundColor: Colors.green,
      msg: mesaj,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 18.0,
    );
  }

  String _durumMesaji(bool onay, bool tamamlandi, bool durum) {
    String mesaj = "";
    if (durum) {
      if (onay) {
        mesaj = "Durum: İsteğiniz Onaylandı.";
        if (tamamlandi) {
          mesaj = "Durum: İsteğiniz Tamamlandı.";
        }
      } else {
        mesaj = "Durum: Onaylanması Bekleniyor...";
        if (tamamlandi) {
          mesaj = "Durum: İsteğiniz Tamamlandı.";
        }
      }
    } else {
      if (onay) {
        mesaj = "Durum: Onayladınız.";
        if (tamamlandi) {
          mesaj = "Durum: İstek Tamamlandı.";
        }
      } else {
        mesaj = "Durum: Onayınızı Bekleniyor...";
        if (tamamlandi) {
          mesaj = "Durum: İstek Tamamlandı.";
        }
      }
    }
    return mesaj;
  }

  String _tarihVeSaatiVer(DateTime createdAt) {
    List<String> aylar = [
      "Ocak",
      "Şubat",
      "Mart",
      "Nisan",
      "Mayıs",
      "Haziran",
      "Temmuz",
      "Ağustos",
      "Eylül",
      "Ekim",
      "Kasım",
      "Aralık"
    ];
    List<String> saatString = [
      "00",
      "01",
      "02",
      "03",
      "04",
      "05",
      "06",
      "07",
      "08",
      "09"
    ];

    String tarih = createdAt.day.toString() +
        " " +
        aylar[createdAt.month - 1] +
        " " +
        createdAt.year.toString();
    String saat, dakika;
    if (createdAt.hour >= 0 && createdAt.hour < 10) {
      saat = saatString[createdAt.hour];
    } else {
      saat = createdAt.hour.toString();
    }

    if (createdAt.minute >= 0 && createdAt.minute < 10) {
      dakika = saatString[createdAt.minute];
    } else {
      dakika = createdAt.minute.toString();
    }

    return tarih + " " + saat + ":" + dakika;
  }

  Widget _istekDetayUrunCard(Urun urun) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(3),
          height: 150,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: ExtendedImage.network(
                        urun.photoURL!,
                        cache: true,
                      ),
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
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
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Adet: " + urun.adet.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ),
                        Spacer(),
                        AutoSizeText("Urun Kod: " + urun.urunKodu!)
                        //Spacer(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(color: Colors.grey),
      ],
    );
  }

  _islemButton(int index, Sepet sepet) {
    final _islemModel = Provider.of<IslemViewModel>(context);
    if (sepet.onay!) {
      if (sepet.tamamlandi!) {
        return AutoSizeText(
          "İstek Tamamlandı.",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        );
      } else {
        return ElevatedButton(
            onPressed: () {
              _islemModel.gelenIslemlerim[index].tamamlandi = true;
              _islemModel.tamamla(sepet.sepetID!);
              //setState(() {});
            },
            child: Text("Tamamla"));
      }
    } else {
      return ElevatedButton(
          onPressed: () {
            _islemModel.gelenIslemlerim[index].onay = true;
            _islemModel.onayla(sepet.sepetID!);
            //setState(() {});
          },
          child: Text("Onayla"));
    }
  }
}
