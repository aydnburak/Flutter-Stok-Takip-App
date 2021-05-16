import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/drawer_menu.dart';
import 'package:stok_app/Components/sepet_urun_card.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class SepetPage extends StatefulWidget {
  @override
  _SepetPageState createState() => _SepetPageState();
}

class _SepetPageState extends State<SepetPage> {
  @override
  void initState() {
    final _islemModel = Provider.of<IslemViewModel>(context, listen: false);
    if (!_islemModel.sepetimgeldimi) {
      print("db den sepetiniz getiriliyor");
      _islemModel.getSepetim();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _islemModel = Provider.of<IslemViewModel>(context);
    return Scaffold(
      drawer: DrawerMenu(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text("SEPET"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _listelemeBolumu(),
          _islemModel.sepetim.isNotEmpty ? _buttomBolumu() : Container(),
        ],
      ),
    );
  }

  _listelemeBolumu() {
    final _islemModel = Provider.of<IslemViewModel>(context);

    if (_islemModel.sepetim.isNotEmpty) {
      return Expanded(
        child: GridView.builder(
          itemCount: _islemModel.sepetim.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) =>
              SepetUrunCard(urun: _islemModel.sepetim[index]),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.shopping_cart_outlined,
                color: Theme.of(context).primaryColor,
                size: 120,
              ),
              AutoSizeText(
                "Sepetinizde Ürün Yok veya Yükleniyor...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36),
              )
            ],
          ),
        ),
      );
    }
  }

  _buttomBolumu() {
    final _userModel = Provider.of<UserViewModel>(context);
    final _islemModel = Provider.of<IslemViewModel>(context);
    return Container(
      height: 60,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, -1))],
      ),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText("Gidecek Ust Üye:", style: TextStyle(fontSize: 10)),
              AutoSizeText(
                _userModel.kullanici!.ustUyeName!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          _userModel.kullanici!.bagimli == true
              ? ElevatedButton(
                  onPressed: () {
                    try {
                      _islemModel.sepetSave();
                    } catch (e) {} finally {
                      toastMesaj('İsteğiniz Gönderildi...');
                      _islemModel.allDeleteSepetim();
                      //setState(() {});
                    }
                  },
                  child: Text("İstek Gönder"))
              : AutoSizeText(
                  "Yetkiliniz İstek Hakkınızı Pasif Yaptı.",
                  style: TextStyle(color: Colors.green),
                ),
        ],
      ),
    );
  }

  void toastMesaj(String mesaj) {
    Fluttertoast.showToast(
      backgroundColor: Colors.green,
      msg: mesaj,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 18.0,
    );
  }
}
