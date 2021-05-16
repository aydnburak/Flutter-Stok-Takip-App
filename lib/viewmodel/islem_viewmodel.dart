import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/models/sepet_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/repository/islem_repository.dart';

import '../models/urun_model.dart';

enum IslemState { Idle, Busy }

class IslemViewModel with ChangeNotifier {
  IslemState _state = IslemState.Idle;
  IslemRepository _islemRepository = locator<IslemRepository>();
  Kullanici? user;
  Kullanici? ustUser;
  bool _sepetimgeldimi = false;
  bool _isteklerGeldimi = false;
  List<Urun> _sepetim = [];
  List<Sepet> _myIslemlerim = [];
  List<Sepet> _gelenIslemlerim = [];

  List<Urun> get sepetim => _sepetim;

  set setSepetimGeldimi(bool value) {
    _sepetimgeldimi = value;
  }

  set setIsteklerGeldimi(bool value) {
    _isteklerGeldimi = value;
  }

  bool get isteklerGeldimi => _isteklerGeldimi;

  bool get sepetimgeldimi => _sepetimgeldimi;

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

  Future<void> getIsteklerim() async {
    _myIslemlerim = await _islemRepository.getSepetlerim(user!.userID!, true);
    notifyListeners();
  }

  Future<void> getIslemlerim() async {
    _myIslemlerim = await _islemRepository.getSepetlerim(user!.userID!, true);
    _gelenIslemlerim = await _islemRepository.getSepetlerim(user!.userID!, false);
    _isteklerGeldimi = true;
    notifyListeners();
  }

  Future<void> islemSepetDelete(String sepetID) async {
    await _islemRepository.islemSepetDelete(sepetID);
    //notifyListeners();
  }

  Future<void> allDeleteSepetim() async {
    _sepetim = [];
    await _islemRepository.allSepetimiSil(user!.userID!);
    notifyListeners();
  }

  Future<void> addSepetim(Urun urun) async {
    if (_sepetimgeldimi) {
      bool durum = true;
      for (Urun sepettekiUrun in sepetim) {
        if (sepettekiUrun.urunID == urun.urunID) {
          sepettekiUrun.adet = sepettekiUrun.adet! + urun.adet!;
          durum = false;
        }
      }
      if (durum) {
        sepetim.add(urun);
      }
      await _islemRepository.addSepetim(urun, user!.userID!);
    } else {
      await _islemRepository.addSepetim(urun, user!.userID!);
    }
  }

  Future<void> sepetUrunAdetGuncelle(String urunID, int adet) async {
    if (_sepetimgeldimi) {
      if (sepetim.isNotEmpty) {
        for (Urun sepettekiUrun in sepetim) {
          if (sepettekiUrun.urunID == urunID) {
            sepettekiUrun.adet = adet;
          }
        }
      }
      notifyListeners();
      await _islemRepository.sepetUrunAdetGuncelle(user!.userID!, urunID, adet);
    } else {
      await _islemRepository.sepetUrunAdetGuncelle(user!.userID!, urunID, adet);
    }
  }

  Future<void> getSepetim() async {
    _sepetimgeldimi = true;
    _sepetim = await _islemRepository.getSepetim(user!.userID!);
    notifyListeners();
  }

  Future<void> sepetUrunSil(String urunID) async {
    if (_sepetimgeldimi) {
      List<Urun> newList = [];
      for (Urun urun in _sepetim) {
        print(urun.adi);
        if (urun.urunID != urunID) {
          print(urun.adi);
          newList.add(urun);
        }
      }
      _sepetim = newList;
      notifyListeners();

      await _islemRepository.sepetUrunSil(urunID, user!.userID!);
    } else {
      await _islemRepository.sepetUrunSil(urunID, user!.userID!);
    }
    //notifyListeners();
  }

  Future<void> sepetSave() async {
    await _islemRepository.sepetSave(user!, ustUser!, _sepetim);
  }

  Future<void> bildirimiKapat(String userID) async {
    await _islemRepository.bildirimiKapat(userID);
  }

  Future<void> onayla(String sepetID) async {
    await _islemRepository.onayla(sepetID);
    notifyListeners();
  }

  Future<void> tamamla(String sepetID) async {
    await _islemRepository.tamamla(sepetID);
    notifyListeners();
  }
}
