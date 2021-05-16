import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/favoriler_page.dart';
import 'package:stok_app/app/haber_bulteni_page.dart';
import 'package:stok_app/app/home_page.dart';
import 'package:stok_app/app/istekler/tabbar.dart';
import 'package:stok_app/app/landing_page.dart';
import 'package:stok_app/app/sepet_page.dart';
import 'package:stok_app/app/stok_screen/stok_page.dart';
import 'package:stok_app/app/topluluk_page.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("drawer menu acıldı");
    final _userModel = Provider.of<UserViewModel>(context);
    final _urunModel = Provider.of<UrunViewModel>(context);
    final _islemModel = Provider.of<IslemViewModel>(context);
    return SafeArea(
      child: Drawer(
        child: Center(
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: AutoSizeText(
                              _userModel.kullanici!.name!,
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        AutoSizeText(
                          "Yetkiliniz: " + _userModel.kullanici!.ustUyeName!,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "Üye No:" + _userModel.kullanici!.uyeNo!,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          "Rütbeniz:" + _userModel.kullanici!.rutbe!,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                  drawerItem(
                      icon: Icons.home,
                      text: "ANA SAYFA",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }),
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: AutoSizeText("İSTEKLER"),
                          ),
                          Spacer(),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("bildirim")
                                .doc(_userModel.kullanici!.userID)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Container();
                              }
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container();
                              }

                              if (snapshot.data!.data() != null) {
                                bool durum = snapshot.data!.data()!['durum'];
                                if (durum) {
                                  return Icon(
                                    Icons.circle_notifications,
                                    color: Colors.green,
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            },
                          ),
                          Icon(Icons.arrow_right)
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TabbarPage(),
                          ),
                        );

                        _islemModel.bildirimiKapat(_userModel.kullanici!.userID!);
                      },
                    ),
                  ),
                  drawerItem(
                      icon: Icons.shopping_basket_outlined,
                      text: "Sepet",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SepetPage(),
                          ),
                        );
                      }),
                  drawerItem(
                      icon: Icons.storage,
                      text: "STOK",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StokPage(),
                          ),
                        );
                      }),
                  drawerItem(
                      icon: Icons.favorite,
                      text: "FAVORİLER",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FavorilerPage(),
                          ),
                        );
                      }),
                  drawerItem(
                      icon: Icons.group,
                      text: "TOPLULUK",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ToplulukPage(),
                          ),
                        );
                      }),
                  drawerItem(
                      icon: Icons.notifications_active,
                      text: "HABER BÜLTENİ",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HaberBulteniPage(),
                          ),
                        );
                      }),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () {
                        _islemModel.setIsteklerGeldimi = false;
                        _islemModel.setSepetimGeldimi = false;
                        _urunModel.depoOpen = false;
                        _urunModel.homeOpen = false;
                        _userModel.setKullanici = null;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => LandingPage()),
                            (route) => false);
                        _userModel.signOut();
                      },
                      style: ElevatedButton.styleFrom(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("ÇIKIŞ"),
                          SizedBox(width: 10),
                          Icon(Icons.logout),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  drawerItem({IconData? icon, String? text, Null Function()? onTap}) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide()),
      ),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: AutoSizeText(text!),
            ),
            Expanded(child: Container()),
            Icon(Icons.arrow_right)
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
