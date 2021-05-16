import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/models/depo_urun_list_model.dart';
import 'package:stok_app/models/depo_urun_model.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class DateUpdate extends StatefulWidget {
  final TarihList tarihList;
  final DepoUrun depoUrun;

  const DateUpdate({Key? key, required this.tarihList, required this.depoUrun}) : super(key: key);

  @override
  _DateUpdateState createState() => _DateUpdateState();
}

class _DateUpdateState extends State<DateUpdate> {
  late int adet;
  bool refresh = false;

  @override
  void initState() {
    super.initState();
    adet = widget.tarihList.adet;
  }

  @override
  Widget build(BuildContext context) {
    final _urunModel = Provider.of<UrunViewModel>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(tarih(widget.tarihList.createdAt)),
          FittedBox(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (adet > 1) adet--;
                        refresh = true;
                      });
                    }),
                Text(adet.toString()),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        adet++;
                        refresh = true;
                      });
                    }),
              ],
            ),
          ),
          FittedBox(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.rotate_left_outlined, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        adet = widget.tarihList.adet;
                        refresh = false;
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.save, color: refresh == true ? Colors.green : Colors.grey),
                    onPressed: () {
                      if (refresh) {
                        _urunModel.updateDopo1(
                            widget.depoUrun.urunID!, widget.tarihList.createdAt, adet);
                        refresh = false;
                      }
                    }),
                IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Ürün Sil"),
                              content: Text("Silmek İstediğinizden Eminmisiniz."),
                              actions: [
                                TextButton(
                                  child: Text("İPTAL"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: Text("SİL", style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    _urunModel.deleteDepo1(
                                        widget.depoUrun.urunID!, widget.tarihList.createdAt);
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String tarih(DateTime _tarih) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(_tarih.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
}
