import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/topluluk_page.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

enum FormDurum { Dolu, Bos }
enum Sifre { On, Off }

class ToplulukAddPage extends StatefulWidget {
  @override
  _ToplulukAddPageState createState() => _ToplulukAddPageState();
}

class _ToplulukAddPageState extends State<ToplulukAddPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _uyeNo, _password, _errorText;
  var _formDurum = FormDurum.Bos;
  var _sifre = Sifre.Off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Üye Kayıt"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
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
                        Icons.account_box_outlined,
                        color: Colors.green,
                      ),
                      labelText: "Ad Soyad",
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
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (girilenUyeNo) {
                    _uyeNo = girilenUyeNo;
                  },
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Üye No Boş Olamaz';
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
                      labelText: 'Üye Numarası',
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
                      labelText: 'Şifre',
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
                      "Kaydet",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void durumDegis() {
    setState(() {
      _formDurum == FormDurum.Bos
          ? _formDurum = FormDurum.Dolu
          : _formDurum = FormDurum.Bos;
    });
  }

  Future<void> buttunaBasildi() async {
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    _errorText = null;
    if (_formDurum == FormDurum.Bos) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        durumDegis();
        try {
          await _userModel.uyeAdd(_name!, _uyeNo!, _password!);
        } catch (e) {
          _errorText = hata(e.toString());
        } finally {
          if (_errorText != null) {
            print("error var");
            durumDegis();
          } else {
            print("error yok");

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ToplulukPage(),
              ),
            );
            Navigator.pop(context);
            await _userModel.altUyeleriGetir();
          }
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
      return "Üye No Kullanımda";
    } else {
      return "Bir Sorun Oluştu. Tekrar Deneyiniz";
    }
  }
}
