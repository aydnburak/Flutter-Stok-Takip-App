import 'package:flutter/material.dart';
import 'package:stok_app/app/urun_detay_page/components/buttom_bar_view.dart';
import 'package:stok_app/app/urun_detay_page/components/urun_data_view.dart';
import 'package:stok_app/models/urun_model.dart';

class DetayScreen extends StatefulWidget {
  final Urun? urun;
  final bool? fav;

  DetayScreen({required this.urun, required this.fav});

  @override
  _DetayScreenState createState() => _DetayScreenState();
}

class _DetayScreenState extends State<DetayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UrunDataView(urun: widget.urun!, fav: widget.fav!),
            DetailButtonBarView(urun: widget.urun!),
          ],
        ),
      ),
    );
  }
}
