import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/home_page.dart';
import 'package:stok_app/app/sign_in_page.dart';
import 'package:stok_app/app/splash_screen_page.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);

    if (_userModel.state == ViewState.Idle) {
      if (_userModel.kullanici == null) {
        return SignInPage();
      } else {
        final _urunModel = Provider.of<UrunViewModel>(context);
        _urunModel.userID = _userModel.kullanici!.userID;
        final _islemModel = Provider.of<IslemViewModel>(context);
        _islemModel.user = _userModel.kullanici;
        return HomePage();
      }
    } else {
      return SplashScreenPage();
    }
  }
}
