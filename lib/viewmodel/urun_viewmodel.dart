import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/repository/urun_repository.dart';

enum UrunState { Idle, Busy }

class UrunViewModel with ChangeNotifier {
  UrunState _state = UrunState.Idle;
  UrunRepository _urunRepository = locator<UrunRepository>();
  List<Urun> _urunler = [];

  List<Urun> get urunler => _urunler;

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
}
