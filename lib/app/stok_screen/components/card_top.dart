import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/models/depo_urun_list_model.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class CardTop extends StatelessWidget {
  final DepoUrunList depoUrunList;
  final VoidCallback onPress;
  final Widget iconWidget;

  const CardTop(
      {Key? key, required this.depoUrunList, required this.iconWidget, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _urunModel = Provider.of<UrunViewModel>(context);
    bool _fav = _urunModel.searchFavoriler(depoUrunList.depoUrun.urunID!);
    return Container(
      height: 150,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: "${depoUrunList.depoUrun.photoURL!}",
              child: ExtendedImage.network(
                depoUrunList.depoUrun.photoURL!,
                cache: true,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Ürün Kodu:" + depoUrunList.depoUrun.urunKodu!,
                        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey.shade600),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_fav) {
                            _urunModel.deleteFavoriler(depoUrunList.depoUrun.urunID!);
                          } else {
                            _urunModel.addFavoriler(depoUrunList.urunVer);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, -1))
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
                Container(
                  height: 40,
                  child: Center(
                    child: AutoSizeText(
                      depoUrunList.depoUrun.adi!,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 15,
                  child: Text(
                    "Adet:" + depoUrunList.urunTotalAdet(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(icon: iconWidget, onPressed: onPress)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
