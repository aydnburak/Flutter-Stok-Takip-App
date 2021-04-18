import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/models/sepet_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/repository/islem_repository.dart';

enum IslemState { Idle, Busy }

class IslemViewModel with ChangeNotifier {
  IslemState _state = IslemState.Idle;
  IslemRepository _islemRepository = locator<IslemRepository>();
  Kullanici? user;
  Kullanici? ustUser;
  bool _isteklerGeldimi = false;
  List<Urun> _sepetim = [];
  List<Sepet> _myIslemlerim = [];
  List<Sepet> _gelenIslemlerim = [];

  List<Urun> get sepetim => _sepetim;

  bool get isteklerGeldimi => _isteklerGeldimi;

  List<Sepet> get gelenIslemlerim => _gelenIslemlerim;

  List<Sepet> get myIslemlerim => _myIslemlerim;

  IslemState get state => _state;

  set state(IslemState value) {
    _state = value;
    notifyListeners();
  }

  IslemViewModel() {
    print("islem viewmodel calıştı");
  }

  Future<void> getUstYetkili() async {
    ustUser = await _islemRepository.getUstYetkili(user!);
  }

  Future<void> getIslemlerim() async {
    _myIslemlerim = await _islemRepository.getSepetlerim(user!.userID!, true);
    _gelenIslemlerim = await _islemRepository.getSepetlerim(ustUser!.userID!, false);
    _isteklerGeldimi = true;
    notifyListeners();
  }

  Future<void> islemSepetDelete(String sepetID) async {
    await _islemRepository.islemSepetDelete(sepetID);
    notifyListeners();
  }

  void allDeleteSepetim() {
    _sepetim = [];
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

  Future<void> sepetSave() async {
    await _islemRepository.sepetSave(user!, ustUser!, _sepetim);
  }
}
