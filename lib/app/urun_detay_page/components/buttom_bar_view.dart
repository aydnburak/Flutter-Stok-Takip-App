import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/Components/add_remove_button.dart';
import 'package:stok_app/models/depo_urun_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/viewmodel/islem_viewmodel.dart';
import 'package:stok_app/viewmodel/urun_viewmodel.dart';

class DetailButtonBarView extends StatefulWidget {
  final Urun urun;

  const DetailButtonBarView({Key? key, required this.urun}) : super(key: key);

  @override
  _DetailButtonBarViewState createState() => _DetailButtonBarViewState();
}

class _DetailButtonBarViewState extends State<DetailButtonBarView> {
  DateTime? tarih;
  bool depoDetail = false;
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final _urunModel = Provider.of<UrunViewModel>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, -1))],
      ),
      height: depoDetail == false ? 60 : 150,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddRemoveButton(
                  value: selectedIndex,
                  remove: () {
                    setState(() {
                      if (selectedIndex > 1 && selectedIndex < 11) selectedIndex--;
                    });
                  },
                  add: () {
                    setState(() {
                      if (selectedIndex > 0 && selectedIndex < 10) selectedIndex++;
                    });
                  },
                ),
                IconButton(
                  icon: depoDetail == false ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      depoDetail = !depoDetail;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      final _islemModel = Provider.of<IslemViewModel>(context, listen: false);

                      if (depoDetail) {
                        if (tarih != null) {
                          toastMesaj("Depoya Eklendi.", null);
                          DepoUrun yeniDepoUrun = DepoUrun.depoUrunAdd(urun: widget.urun);
                          yeniDepoUrun.adet = selectedIndex;
                          yeniDepoUrun.createdAt = tarih;
                          _urunModel.addDepo1(yeniDepoUrun);
                        } else {
                          toastMesaj("Üretim Tarihi Ekleyiniz.", Colors.red);
                        }
                      } else {
                        toastMesaj("Sepete Eklendi.", null);
                        Urun yeniUrun = Urun.urunAdd(urun: widget.urun);
                        yeniUrun.adet = selectedIndex;
                        _islemModel.addSepetim(yeniUrun);
                      }
                      print("tarih : " + tarih.toString());
                      selectedIndex = 1;
                      setState(() {});
                    },
                    child: depoDetail == false ? Text("Sepete Ekle") : Text("Depoya Ekle")),
              ],
            ),
            depoDetail == true ? SizedBox(height: 10) : SizedBox(),
            depoDetail == true
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: DateTimeFormField(
                      dateFormat: DateFormat('dd MMM yyyy'),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        hintStyle: TextStyle(color: Colors.green),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                        suffixIcon: Icon(
                          Icons.event,
                          color: Colors.green,
                        ),
                        labelText: 'Üretim Tarihini Giriniz',
                        hintText: '',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (DateTime? value) {
                        if (value == null || value.toString().isEmpty) {
                          return "Lütfen Tarih Seçiniz...";
                        }
                      },
                      onDateSelected: (DateTime value) {
                        tarih = value;
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void toastMesaj(String mesaj, Color? color) {
    Fluttertoast.showToast(
      backgroundColor: color ?? Colors.green,
      msg: mesaj,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 18.0,
    );
  }
}
