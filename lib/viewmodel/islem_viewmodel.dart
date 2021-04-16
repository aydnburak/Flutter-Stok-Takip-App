import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/repository/islem_repository.dart';

enum IslemState { Idle, Busy }

class IslemViewModel with ChangeNotifier {
  IslemState _state = IslemState.Idle;
  IslemRepository _islemRepository = locator<IslemRepository>();

  List<Urun> _sepetim = [];

  List<Urun> get sepetim => _sepetim;

  IslemState get state => _state;

  set state(IslemState value) {
    _state = value;
    notifyListeners();
  }

  IslemViewModel() {
    print("islem viewmodel calıştı");
  }

  void addSepetim(Urun urun) {
    for (Urun sepettekiUrun in sepetim) {
      if (sepettekiUrun.urunID == urun.urunID) {
        sepettekiUrun.adet = sepettekiUrun.adet! + urun.adet!;
        return;
      }
    }
    print("ekledim");
    sepetim.add(urun);
  }

  void sepetUrunAdetGuncelle(String urunID, int adet) {
    if (sepetim.isNotEmpty) {
      for (Urun sepettekiUrun in sepetim) {
        if (sepettekiUrun.urunID == urunID) {
          sepettekiUrun.adet = adet;
          return;
        }
      }
    }
  }

  void sepetUrunSil(String urunID) {
    sepetim.removeWhere((urun) => urun.urunID == urunID);
    notifyListeners();
  }
}
