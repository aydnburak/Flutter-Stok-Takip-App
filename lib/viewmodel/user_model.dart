import 'package:flutter/material.dart';
import 'package:stok_app/locator.dart';
import 'package:stok_app/repository/user_repository.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    state = ViewState.Busy;
  }
}
