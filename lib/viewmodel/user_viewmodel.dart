import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/repository/user_repository.dart';

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  Kullanici? _kullanici;
  List<Kullanici> _uyelerim = [];

  List<Kullanici> get uyelerim => _uyelerim;

  Kullanici? get kullanici => _kullanici;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserViewModel() {
    currentUser();
  }

  Future<void> currentUser() async {
    try {
      state = ViewState.Busy;
      _kullanici = await _userRepository.currentUser();
      print("current User :" + _kullanici!.userID!);
    } catch (e) {
      print("currentUser hatası : " + e.toString());
    } finally {
      state = ViewState.Idle;
    }
  }

  Future<void> signOut() async {
    try {
      state = ViewState.Busy;
      _kullanici = null;
      await _userRepository.signOut();
    } catch (e) {
      debugPrint("signOut Hatası : " + e.toString());
    } finally {
      state = ViewState.Idle;
    }
  }

  Future<void> signInWithEmailAndPassword(String uyeNo, String sifre) async {
    _kullanici = await _userRepository.signInWithEmailAndPassword(uyeNo, sifre);

    if (_kullanici != null) {
      state = ViewState.Idle;
    }
  }

  Future<bool> uyeAdd(String name, String uyeNo, String sifre) async {
    String userID = kullanici!.userID!;
    String ustUyeName = kullanici!.name!;
    String ustUyeEmail = kullanici!.email!;
    String ustUyeS = kullanici!.a!;
    return await _userRepository.uyeAdd(
        name, uyeNo, sifre, userID, ustUyeName, ustUyeEmail, ustUyeS);
  }

  Future<void> createUserWithEmailAndPassword(
      String uyeNo, String sifre, String name) async {
    _kullanici = await _userRepository.createUserWithEmailAndPassword(uyeNo, sifre, name);

    if (_kullanici != null) {
      state = ViewState.Idle;
    }
  }

  Future<void> altUyeleriGetir() async {
    print(_kullanici!.userID!.toString());
    _uyelerim = await _userRepository.altUyeleriGetir(_kullanici!.userID!);
    print(_uyelerim.length);
    state = ViewState.Idle;
  }
}
