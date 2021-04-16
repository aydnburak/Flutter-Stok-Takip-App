import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/app/detay_screen.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class UrunCard extends StatelessWidget {
  final Urun? urunModel;

  UrunCard({this.urunModel});

  @override
  Widget build(BuildContext context) {
    final _urunModel = Provider.of<UrunViewModel>(context);
    bool _fav = _urunModel.searchFavoriler(urunModel!.urunID!);

    return GestureDetector(
      onTap: () {
        print("urun karta tıklandı");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetayScreen(
              urun: urunModel,
              fav: _fav,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  urunModel!.adet != null
                      ? GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                              backgroundColor: Colors.green,
                              msg: "Siliniyor...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 18.0,
                            );
                            _urunModel.deleteDepo(urunModel!.urunID!);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 3),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(0, -1))
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Container(),
                  AutoSizeText(
                    "Kod:" + urunModel!.urunKodu!,
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.grey.shade600),
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      if (_fav) {
                        _urunModel.deleteFavoriler(urunModel!.urunID!);
                      } else {
                        _urunModel.addFavoriler(urunModel!);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey, blurRadius: 5, offset: Offset(0, -1))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Icon(
                        _fav == false ? Icons.favorite_border : Icons.favorite,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Hero(
                tag: "${urunModel!.photoURL!}",
                child: ExtendedImage.network(
                  urunModel!.photoURL!,
                  cache: true,
                ),
              ),
            ),
            Container(
              height: 40,
              child: Center(
                child: AutoSizeText(
                  urunModel!.adi!,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
            urunModel!.adet != null
                ? Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 15,
                    child: Text(
                      "Adet:" + urunModel!.adet.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
