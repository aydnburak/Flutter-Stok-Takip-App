import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stok_app/app/istekler/istek_detay_page.dart';
import 'package:stok_app/models/sepet_model.dart';

class IslemCard extends StatelessWidget {
  final Sepet sepet;
  final int index;
  final bool durum;

  IslemCard({required this.sepet, required this.index, required this.durum});

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
                  durum == true
                      ? AutoSizeText("Yetkili: " + sepet.ustUserName!)
                      : AutoSizeText("Kimden: " + sepet.userName!),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            IstekDetayPage(sepet: sepet, index: index, durum: durum)));
                  },
                  child: Row(
                    children: <Widget>[Text("Detaylar"), Icon(Icons.arrow_right)],
                  ))
            ],
          ),
          Divider(color: Colors.grey),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Expanded(
                    child: Center(
                  child:
                      AutoSizeText(_durumMesaji(sepet.onay!, sepet.tamamlandi!, durum)),
                )),
                sepet.onay == true
                    ? sepet.tamamlandi == true
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.done, color: Colors.green)
                    : Icon(Icons.hourglass_top, color: Colors.green),
              ],
            ),
          ),
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
      }
    } else {
      if (onay) {
        mesaj = "Durum: Onayladınız.";
        if (tamamlandi) {
          mesaj = "Durum: İstek Tamamlandı.";
        }
      } else {
        mesaj = "Durum: Onayınızı Bekleniyor...";
      }
    }
    return mesaj;
  }
}
