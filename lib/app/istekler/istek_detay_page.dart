import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/models/sepet_model.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';

class IstekDetayPage extends StatefulWidget {
  Sepet sepet;
  int index;
  bool durum;

  IstekDetayPage({required this.sepet, required this.index, required this.durum});

  @override
  _IstekDetayPageState createState() => _IstekDetayPageState();
}

class _IstekDetayPageState extends State<IstekDetayPage> {
  late Sepet sepet;

  @override
  void initState() {
    sepet = widget.sepet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _islemModel = Provider.of<IslemViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("İstek Detayları"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Dikkat!"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("İstegi bir daha Göremeyeceksiniz!"),
                              Text("Silmek istediginizden Eminmisiniz?"),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Hayır")),
                            ElevatedButton(
                                onPressed: () {
                                  toastMesaj("İstek Silindi.");
                                  if (widget.durum) {
                                    _islemModel.myIslemlerim.removeAt(widget.index);
                                    _islemModel.islemSepetDelete(sepet.sepetID!);
                                  } else {
                                    _islemModel.gelenIslemlerim.removeAt(widget.index);
                                    _islemModel.islemSepetDelete(sepet.sepetID!);
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text("Evet")),
                          ],
                        ));
              })
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
