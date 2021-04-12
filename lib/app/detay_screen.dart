import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/add_remove_button.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class DetayScreen extends StatefulWidget {
  final Urun? urun;
  final bool? fav;

  DetayScreen({this.urun, this.fav});

  @override
  _DetayScreenState createState() => _DetayScreenState();
}

class _DetayScreenState extends State<DetayScreen> {
  int selectedIndex = 1;
  bool? favbool;
  bool depobool = false;
  int kacTane = 0;
  bool depoButtonKilit = false;

  @override
  void initState() {
    favbool = widget.fav;
    if (widget.urun!.adet == null) {
      _depoKontrol();
    } else {
      selectedIndex = widget.urun!.adet!;
    }

    super.initState();
  }

  void _depoKontrol() async {
    final _urunModel = Provider.of<UrunViewModel>(context, listen: false);
    kacTane = await _urunModel.depoKontrol(widget.urun!);
    print(kacTane.toString());
    setState(() {});
    if (kacTane > 0) depobool = true;
  }

  @override
  Widget build(BuildContext context) {
    final _urunModel = Provider.of<UrunViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Hero(
                              tag: "${widget.urun!.photoURL}",
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide()),
                                ),
                                child: Center(
                                  child: ExtendedImage.network(
                                    widget.urun!.photoURL!,
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
                                  "Kod:" + widget.urun!.urunKodu!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (favbool!) {
                                      favbool = false;
                                      _urunModel.deleteFavoriler(widget.urun!.urunID!);
                                    } else {
                                      favbool = true;
                                      _urunModel.addFavoriler(widget.urun!);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5,
                                            offset: Offset(0, -1))
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(100)),
                                    ),
                                    child: Icon(
                                      favbool == false
                                          ? Icons.favorite_border
                                          : Icons.favorite,
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
                          widget.urun!.adi!,
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.urun!.aciklama1!,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.urun!.aciklama2!,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            depobool == true
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey, blurRadius: 5, offset: Offset(0, -1))
                      ],
                    ),
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Depoda bu üründen " + kacTane.toString() + " adet var.",
                          style:
                              TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, -1))
                ],
              ),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddRemoveButton(
                    value: selectedIndex,
                    remove: () {
                      setState(() {
                        if (selectedIndex != 1) selectedIndex--;
                      });
                    },
                    add: () {
                      setState(() {
                        selectedIndex++;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (!depoButtonKilit) {
                          depoButtonKilit = true;
                          final _urunModel =
                              Provider.of<UrunViewModel>(context, listen: false);
                          Urun yeniUrun = Urun.urunAdd(urun: widget.urun!);

                          toastMesaj(widget.urun!.adet != null
                              ? "Güncelleniyor..."
                              : "Depoya Ekleniyor...");
                          if (depobool) {
                            kacTane = selectedIndex + kacTane;
                            _urunModel.depoGuncelle(yeniUrun, selectedIndex);
                          } else {
                            yeniUrun.adet = selectedIndex;
                            _urunModel.addDepo(yeniUrun);
                          }
                          toastMesaj(
                              widget.urun!.adet != null ? "Güncellendi." : "Eklendi.");
                          depoButtonKilit = false;
                        }
                      },
                      child: Text(
                          widget.urun!.adet == null ? "Depoya Ekle" : "Depoyu Güncelle")),
                  ElevatedButton(onPressed: () {}, child: Text("Sepete Ekle")),
                ],
              ),
            ),
          ],
        ),
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
