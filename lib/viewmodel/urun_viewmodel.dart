import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/repository/urun_repository.dart';

enum UrunState { Idle, Busy }

class UrunViewModel with ChangeNotifier {
  UrunState _state = UrunState.Idle;
  UrunRepository _urunRepository = locator<UrunRepository>();
  bool depoOpen = false;
  bool homeOpen = false;
  String? userID;
  List<Urun> _urunler = [];
  List<Urun> _favoriUrunler = [];
  List<Urun> _depoUrunler = [];

  List<Urun> get urunler => _urunler;

  List<Urun> get favoriUrunler => _favoriUrunler;

  List<Urun> get depoUrunler => _depoUrunler;

  UrunState get state => _state;

  set state(UrunState value) {
    _state = value;
    notifyListeners();
  }

  UrunViewModel() {
    getUrunler("TEMİZLİK GRUBU", null);
  }

  Future<void> getUrunler(String? tip1, String? tip2) async {
    state = UrunState.Busy;
    _urunler = await _urunRepository.getUrunler(tip1, tip2);
    state = UrunState.Idle;
  }

  Future<void> addFavoriler(Urun urun) async {
    _favoriUrunler.add(urun);
    await _urunRepository.addFavoriler(userID!, urun.urunID!);
    state = UrunState.Idle;
  }

  Future<void> deleteFavoriler(String urunID) async {
    List<Urun> list = [];
    if (_favoriUrunler.isNotEmpty) {
      for (Urun urun in _favoriUrunler) {
        if (urun.urunID != urunID) {
          list.add(urun);
        }
      }
    }
    _favoriUrunler = list;
    await _urunRepository.deleteFavoriler(userID!, urunID);
    state = UrunState.Idle;
  }

  bool searchFavoriler(String urunID) {
    //return await _urunRepository.searchFavoriler(userID, urunID);
    if (_favoriUrunler.isNotEmpty) {
      for (Urun urun in _favoriUrunler) {
        if (urun.urunID == urunID) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> getFavoriler() async {
    _favoriUrunler = await _urunRepository.getFavoriler(userID!);
    print("favoriler geldi");
    state = UrunState.Idle;
  }

  Future<bool> addDepo(Urun urun) async {
    if (depoOpen) {
      bool sonuc = kontrol(urun);
      if (!sonuc) {
        print("yokum");
        _depoUrunler.add(urun);
        await _urunRepository.addDepo(userID!, urun.urunID!, urun.adet!);
        state = UrunState.Idle;
        return true;
      } else {
        print("varım");
        for (Urun urunum in _depoUrunler) {
          if (urunum.urunID == urun.urunID) {
            urunum.adet = urun.adet;
          }
        }
        await _urunRepository.addDepo(userID!, urun.urunID!, urun.adet!);
        state = UrunState.Idle;
        return false;
      }
    } else {
      await _urunRepository.addDepo(userID!, urun.urunID!, urun.adet!);
      state = UrunState.Idle;

      return true;
    }
  }

  Future<void> getDepo() async {
    _depoUrunler = await _urunRepository.getDepo(userID!);
    print("depo geldi");
    state = UrunState.Idle;
  }

  Future<void> deleteDepo(String urunID) async {
    if (depoOpen) {
      List<Urun> list = [];
      if (_depoUrunler.isNotEmpty) {
        for (Urun urun in _depoUrunler) {
          if (urun.urunID != urunID) {
            list.add(urun);
          }
        }
      }
      _depoUrunler = list;
      await _urunRepository.deleteDepo(userID!, urunID);
    } else {
      await _urunRepository.deleteDepo(userID!, urunID);
    }
    state = UrunState.Idle;
  }

  bool kontrol(Urun urun) {
    for (Urun urundepo in _depoUrunler) {
      if (urun.urunID == urundepo.urunID) {
        return true;
      }
    }
    return false;
  }

  Future<int> depoKontrol(Urun urun) async {
    int kacTane = 0;
    if (depoOpen) {
      for (Urun depodakiUrun in _depoUrunler) {
        if (depodakiUrun.urunID == urun.urunID) {
          kacTane = depodakiUrun.adet!;

          return kacTane;
        }
      }

      return kacTane;
    } else {
      kacTane = await _urunRepository.depoKontrol(urun, userID!);

      return kacTane;
    }
  }

  Future<void> depoGuncelle(Urun yeniUrun, int selectedIndex) async {
    if (depoOpen) {
      for (Urun depodakiUrun in _depoUrunler) {
        if (depodakiUrun.urunID == yeniUrun.urunID) {
          depodakiUrun.adet = depodakiUrun.adet! + selectedIndex;
          await _urunRepository.depoGuncelle(userID!, yeniUrun, selectedIndex);
        }
      }
    } else {
      await _urunRepository.depoGuncelle(userID!, yeniUrun, selectedIndex);
    }
    state = UrunState.Idle;
  }
}
