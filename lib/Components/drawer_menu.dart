import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/favoriler_page.dart';
import 'package:stok_app/app/haber_bulteni_page.dart';
import 'package:stok_app/app/home_page.dart';
import 'package:stok_app/app/istekler/tabbar.dart';
import 'package:stok_app/app/sepet_page.dart';
import 'package:stok_app/app/stok_page.dart';
import 'package:stok_app/app/topluluk_page.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  void initState() {
    print("drawer menu acıldı");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Drawer(
      child: Center(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Center(
                            child: AutoSizeText(
                              _userModel.kullanici!.name!,
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: AutoSizeText(
                            "Yetkiliniz: " + _userModel.kullanici!.ustUyeName!,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: AutoSizeText(
                                    "No:" + _userModel.kullanici!.uyeNo!,
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  child: AutoSizeText(
                                    "Rütbe:" + _userModel.kullanici!.rutbe!,
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }),
                drawerItem(
                    icon: Icons.shopping_cart,
                    text: "İSTEKLER",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TabbarPage(),
                        ),
                      );
                    }),
                drawerItem(
                    icon: Icons.shopping_basket_outlined,
                    text: "Sepet",
                    onTap: () {
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
                    onPressed: () async {
                      await _userModel.signOut();
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
            icon != null ? Icon(icon) : Icon(Icons.edit),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(text!),
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
