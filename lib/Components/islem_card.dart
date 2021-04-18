import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/istekler/istek_detay_page.dart';
import 'package:stok_app/models/sepet_model.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class IslemCard extends StatefulWidget {
  Sepet sepet;
  int index;
  bool durum;

  IslemCard({required this.sepet, required this.index, required this.durum});

  @override
  _IslemCardState createState() => _IslemCardState();
}

class _IslemCardState extends State<IslemCard> {
  late Sepet sepet;

  @override
  void initState() {
    sepet = widget.sepet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)],
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
                      ? AutoSizeText("Yetkili:" + sepet.ustUserName!)
                      : AutoSizeText("Kimden:" + sepet.userName!),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => IstekDetayPage(
                            sepet: sepet, index: widget.index, durum: widget.durum)));
                  },
                  child: Row(
                    children: <Widget>[Text("Detaylar"), Icon(Icons.arrow_right)],
                  ))
            ],
          ),
          Divider(color: Colors.grey),
          AutoSizeText(_durumMesaji(sepet.onay!, sepet.tamamlandi!, widget.durum)),
        ],
      ),
    );
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

    String tarih = createdAt.day.toString() +
        " " +
        aylar[createdAt.month + 1] +
        " " +
        createdAt.year.toString();

    String saat = createdAt.hour.toString();
    String dakika = createdAt.minute == 0 ? "00" : createdAt.minute.toString();

    return tarih + " " + saat + ":" + dakika;
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
}
