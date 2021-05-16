import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/depo_urun_list_model.dart';
import 'package:stok_app/models/depo_urun_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/repository/urun_repository.dart';

enum UrunState { Idle, Busy }

class UrunViewModel with ChangeNotifier {
  UrunState _state = UrunState.Idle;
  UrunRepository _urunRepository = locator<UrunRepository>();
  bool depoOpen = false;
  bool homeOpen = false;
  int selectedIndex = 0;
  String? userID;
  List<Urun> _urunler = [];
  List<Urun> _favoriUrunler = [];
  List<DepoUrunList> _depoUrunList = [];

  List<DepoUrunList> get depoUrunList => _depoUrunList;

  List<Urun> get urunler => _urunler;

  List<Urun> get favoriUrunler => _favoriUrunler;

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

  Future<void> addDepo1(DepoUrun depoUrun) async {
    depoUrun.userID = userID;

    if (depoOpen) {
      int index =
          depoUrunList.indexWhere((element) => element.depoUrun.urunKodu == depoUrun.urunKodu);
      if (index != -1) {
        int indexCreatedAt = depoUrunList[index]
            .tarihlerim
            .indexWhere((element) => element.createdAt == depoUrun.createdAt);
        if (indexCreatedAt == -1) {
          depoUrunList[index].tarihlerim.add(TarihList(depoUrun.createdAt!, depoUrun.adet!));
        } else {
          depoUrunList[index].tarihlerim[indexCreatedAt].adet += depoUrun.adet!;
        }
        depoUrunList.first.tarihlerim.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        await _urunRepository.addDepo1(depoUrun);
        state = UrunState.Idle;
      } else {
        var _d = DepoUrunList(depoUrun);
        _d.tarihlerim.add(TarihList(depoUrun.createdAt!, depoUrun.adet!));
        depoUrunList.add(_d);
        await _urunRepository.addDepo1(depoUrun);
        state = UrunState.Idle;
      }
    } else {
      await _urunRepository.addDepo1(depoUrun);
      state = UrunState.Idle;
    }
  }

  Future<void> getDepo1() async {
    _depoUrunList = await _urunRepository.getDepo1(userID!);
    state = UrunState.Idle;
  }

  Future<void> deleteDepo1(String urunID, DateTime createdAt) async {
    if (depoOpen) {
      int index = depoUrunList.indexWhere((element) => element.depoUrun.urunID == urunID);
      depoUrunList[index].tarihlerim.removeWhere((element) => element.createdAt == createdAt);
      await _urunRepository.deleteDepo1(userID!, urunID, createdAt);
    } else {
      await _urunRepository.deleteDepo1(userID!, urunID, createdAt);
    }
    state = UrunState.Idle;
  }

  Future<void> updateDopo1(String urunID, DateTime createdAt, int adet) async {
    if (depoOpen) {
      int index = depoUrunList.indexWhere((element) => element.depoUrun.urunID == urunID);
      int indexDate =
          depoUrunList[index].tarihlerim.indexWhere((element) => element.createdAt == createdAt);
      depoUrunList[index].tarihlerim[indexDate].adet = adet;

      await _urunRepository.updateDepo1(userID!, urunID, createdAt, adet);
    } else {
      await _urunRepository.updateDepo1(userID!, urunID, createdAt, adet);
    }
    state = UrunState.Idle;
  }
}
