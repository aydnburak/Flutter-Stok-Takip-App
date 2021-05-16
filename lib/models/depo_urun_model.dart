import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stok_app/models/urun_model.dart';

class DepoUrun {
  String? userID;
  String? urunID;
  String? adi;
  String? urunKodu;
  String? photoURL;
  String? aciklama1;
  String? aciklama2;
  String? tip1;
  String? tip2;
  DateTime? createdAt;
  int? adet;

  @override
  String toString() {
    return 'DepoUrun{userID: $userID, urunID: $urunID, adi: $adi, urunKodu: $urunKodu, photoURL: $photoURL, aciklama1: $aciklama1, aciklama2: $aciklama2, tip1: $tip1, tip2: $tip2, createdAt: $createdAt, adet: $adet}';
  }

  DepoUrun(
      {this.userID,
      this.urunID,
      this.adi,
      this.urunKodu,
      this.photoURL,
      this.aciklama1,
      this.aciklama2,
      this.tip1,
      this.tip2,
      this.createdAt,
      this.adet});

  static DepoUrun depoUrunAdd({required Urun urun}) {
    DepoUrun yeniDepoUrun = DepoUrun(
      urunID: urun.urunID,
      adi: urun.adi,
      urunKodu: urun.urunKodu,
      photoURL: urun.photoURL,
      aciklama1: urun.aciklama1,
      aciklama2: urun.aciklama2,
      tip1: urun.tip1,
      tip2: urun.tip2,
    );
    return yeniDepoUrun;
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'urunID': urunID,
      'adi': adi,
      'urunKodu': urunKodu,
      'photoURL': photoURL,
      'aciklama1': aciklama1,
      'aciklama2': aciklama2,
      'tip1': tip1,
      'tip2': tip2,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'adet': adet,
    };
  }

  DepoUrun.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        urunID = map['urunID'],
        adi = map['adi'],
        urunKodu = map['urunKodu'],
        photoURL = map['photoURL'],
        aciklama1 = map['aciklama1'],
        aciklama2 = map['aciklama2'],
        tip1 = map['tip1'],
        tip2 = map['tip2'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        adet = map['adet'];
}
