import 'package:stok_app/models/depo_urun_model.dart';
import 'package:stok_app/models/urun_model.dart';

class DepoUrunList {
  DepoUrun depoUrun;
  List<TarihList> tarihlerim = [];

  DepoUrunList(this.depoUrun);

  String urunTotalAdet() {
    int donecekAdet = 0;
    for (TarihList tarih in tarihlerim) {
      donecekAdet += tarih.adet;
    }
    return donecekAdet.toString();
  }

  Urun get urunVer => Urun(
        urunID: this.depoUrun.urunID,
        adi: this.depoUrun.adi,
        urunKodu: this.depoUrun.urunKodu,
        photoURL: this.depoUrun.photoURL,
        aciklama1: this.depoUrun.aciklama1,
        aciklama2: this.depoUrun.aciklama2,
        tip1: this.depoUrun.tip1,
        tip2: this.depoUrun.tip2,
      );
}

class TarihList {
  DateTime createdAt;
  int adet;

  TarihList(this.createdAt, this.adet);
}
