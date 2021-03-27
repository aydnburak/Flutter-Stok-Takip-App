import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

enum FormType { Register, Login }
enum FormDurum { Dolu, Bos }
enum Sifre { On, Off }

class SignInAndRegisterPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInAndRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _password, _errorText;
  late String _buttonText, _linkText, _titleText;
  var _formType = FormType.Login;
  var _formDurum = FormDurum.Bos;
  Sifre _sifre = Sifre.Off;

  @override
  Widget build(BuildContext context) {
    _titleText = _formType == FormType.Login ? "Giriş" : "Kayıt";
    _buttonText = _formType == FormType.Login ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.Login ? "Hesabınız Yok Mu? " : "Hesabınız Var Mı? ";
    //final _userModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            //renk gecişi
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    Colors.green,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.green
                  ],
                ),
              ),
            ),

            //form ve google button
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _titleText,
                              style: GoogleFonts.fanwoodText(
                                  fontWeight: FontWeight.bold, fontSize: 50, color: Colors.green),
                            ),
                            _formType != FormType.Login
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextFormField(
                                      onSaved: (girilenName) {
                                        _name = girilenName;
                                      },
                                      validator: (value) {
                                        if (value != null) {
                                          if (value.isEmpty) {
                                            return 'Name Boş Olamaz';
                                          } else if (value.length < 4) {
                                            return '4 Karakterden az Olamaz';
                                          }
                                        }
                                      },
                                      decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.account_box,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Adınız Soyadınız',
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16),
                                              borderSide: BorderSide(color: Colors.green)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16),
                                              borderSide: BorderSide(color: Colors.green)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16),
                                              borderSide: BorderSide(color: Colors.red)),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16),
                                              borderSide: BorderSide(color: Colors.red))),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (girilenEmail) {
                                  _email = girilenEmail;
                                },
                                validator: (value) {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return 'Email Boş Olamaz';
                                    } else if (value.length < 4) {
                                      return '4 Karakterden az Olamaz';
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.green,
                                    ),
                                    hintText: 'Üye Numaranız',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.green)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.green)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.red))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                onSaved: (girilenSifre) {
                                  _password = girilenSifre;
                                },
                                validator: (value) {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return 'Şifre Boş Olamaz';
                                    }
                                  }
                                },
                                obscureText: _sifre == Sifre.Off ? true : false,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye_outlined),
                                      onPressed: () {
                                        setState(() {
                                          _sifre = _sifre == Sifre.Off ? Sifre.On : Sifre.Off;
                                        });
                                      },
                                    ),
                                    icon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.green,
                                    ),
                                    hintText: 'Şifre',
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.green)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.green)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.red))),
                              ),
                            ),
                            _formDurum == FormDurum.Dolu
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                            _errorText != null
                                ? Text(
                                    _errorText!,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Container(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                              child: Container(
                                height: 50,
                                width: 400,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0))),
                                  onPressed: () {
                                    buttunaBasildi();
                                  },
                                  child: Text(
                                    _buttonText,
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    _linkText,
                                    style:
                                        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _formType == FormType.Login
                                            ? _formType = FormType.Register
                                            : _formType = FormType.Login;
                                        _formKey.currentState!.reset();
                                        _errorText = null;
                                      });
                                    },
                                    child: Text(
                                      _formType == FormType.Login ? "Kayıt Ol" : "Giriş Yap",
                                      style: TextStyle(
                                          color: Colors.green, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void durumDegis() {
    setState(() {
      _formDurum == FormDurum.Bos ? _formDurum = FormDurum.Dolu : _formDurum = FormDurum.Bos;
    });
  }

  Future<void> buttunaBasildi() async {
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    _errorText = null;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      durumDegis();
      if (_formType == FormType.Login) {
        try {
          await _userModel.signInWithEmailAndPassword(_email! + "@gmail.com", _password!);
        } catch (e) {
          _errorText = hata(e.toString());
          print("hata : " + e.toString());
          durumDegis();
        }
      } else {
        try {
          await _userModel.createUserWithEmailAndPassword(
              _email! + "@gmail.com", _password!, _name!);
        } catch (e) {
          _errorText = hata(e.toString());
          print("hata : " + e.toString());
          durumDegis();
        }
      }
    }
  }

  String hata(String e) {
    if (e ==
        "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
      return "Şifre Geçerli Değil";
    } else if (e ==
        "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
      return "Email Geçerli Değil";
    } else if (e ==
        "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
      return "Email Kullanımda";
    } else {
      return "Tekrar Deneyiniz";
    }
  }
}
