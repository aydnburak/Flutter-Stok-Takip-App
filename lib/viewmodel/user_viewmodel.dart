import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/repository/user_repository.dart';

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  Kullanici? _kullanici;

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

  Future<void> signInWithEmailAndPassword(String email, String sifre) async {
    _kullanici = await _userRepository.signInWithEmailAndPassword(email, sifre);

    if (_kullanici != null) {
      state = ViewState.Idle;
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String sifre, String name) async {
    _kullanici = await _userRepository.createUserWithEmailAndPassword(email, sifre, name);

    if (_kullanici != null) {
      state = ViewState.Idle;
    }
  }
}
