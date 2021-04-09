import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/repository/urun_repository.dart';

enum UrunState { Idle, Busy }

class UrunViewModel with ChangeNotifier {
  UrunState _state = UrunState.Idle;
  UrunRepository _urunRepository = locator<UrunRepository>();
  String? userID;
  List<Urun> _urunler = [];
  List<Urun> _favoriUrunler = [];

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

  /*
  Future<bool> searchFavoriler( String urunID) async {
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
   */

  Future<void> getFavoriler() async {
    _favoriUrunler = await _urunRepository.getFavoriler(userID!);
    print("favoriler geldi");
    state = UrunState.Idle;
  }
}
