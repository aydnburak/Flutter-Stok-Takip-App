import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/favoriler_page.dart';
import 'package:stok_app/app/home_page.dart';
import 'package:stok_app/app/istek_page.dart';
import 'package:stok_app/app/stok_page.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    return Drawer(
      child: Center(
        child: Stack(
          children: <Widget>[
            ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Text("Hasan Kabze"),
                      Text("Üye ID : 546525"),
                      Text("General"),
                      Row(
                        children: <Widget>[
                          Text("Üst Kişi : Derya "),
                          Expanded(
                            child: Container(),
                          ),
                          IconButton(
                            icon: Icon(Icons.warning),
                            onPressed: () {},
                          )
                        ],
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
                          builder: (context) => IstekPage(),
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
                drawerItem(icon: Icons.group, text: "TOPLULUK", onTap: () {}),
                drawerItem(icon: Icons.notifications_active, text: "HABER BÜLTENİ", onTap: () {}),
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
