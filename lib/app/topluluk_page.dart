import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/drawer_menu.dart';
import 'package:stok_app/Components/topluluk_uye_card.dart';
import 'package:stok_app/app/topluluk_add_page.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class ToplulukPage extends StatefulWidget {
  @override
  _ToplulukPageState createState() => _ToplulukPageState();
}

class _ToplulukPageState extends State<ToplulukPage> {
  @override
  void initState() {
    _getir();
    super.initState();
  }

  void _getir() async {
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    await _userModel.altUyeleriGetir();
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("Topluluk"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ToplulukAddPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          _baslik(),
          _userModel.uyelerim.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _userModel.uyelerim.length,
                    itemBuilder: (context, index) => ToplulukUyeCard(
                      user: _userModel.uyelerim[index],
                      index: index,
                    ),
                  ),
                )
              : _kullaniciYokUI(),
        ],
      ),
    );
  }

  _baslik() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(
            "Alt Üyelerim",
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  _kullaniciYokUI() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.info_outline,
              color: Theme.of(context).primaryColor,
              size: 120,
            ),
            Text(
              "Bir Alt Üyeniz Yok",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36),
            )
          ],
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.7,
    );
  }
}
