import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class UrunDataView extends StatefulWidget {
  final Urun urun;
  final bool fav;

  const UrunDataView({Key? key, required this.urun, required this.fav}) : super(key: key);

  @override
  _UrunDataViewState createState() => _UrunDataViewState();
}

class _UrunDataViewState extends State<UrunDataView> {
  late bool favoriButton;

  @override
  void initState() {
    super.initState();
    favoriButton = widget.fav;
  }

  @override
  Widget build(BuildContext context) {
    final _urunModel = Provider.of<UrunViewModel>(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Hero(
                    tag: "${widget.urun.photoURL}",
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      child: Center(
                        child: ExtendedImage.network(
                          widget.urun.photoURL!,
                          cache: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Spacer(),
                      Text(
                        "Kod:" + widget.urun.urunKodu!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (favoriButton) {
                            favoriButton = false;
                            _urunModel.deleteFavoriler(widget.urun.urunID!);
                          } else {
                            favoriButton = true;
                            _urunModel.addFavoriler(widget.urun);
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
                            favoriButton == false ? Icons.favorite_border : Icons.favorite,
                            size: 30,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.urun.adi!,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.urun.aciklama1!,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.urun.aciklama2!,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
