import 'package:flutter/material.dart';
import 'package:stok_app/app/stok_screen/components/date_update.dart';
import 'package:stok_app/models/depo_urun_list_model.dart';

class DateDetail extends StatelessWidget {
  final DepoUrunList depoUrunList;

  const DateDetail({Key? key, required this.depoUrunList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: depoUrunList.tarihlerim
          .map(
            (e) => DateUpdate(tarihList: e, depoUrun: depoUrunList.depoUrun),
          )
          .toList(),
    );
  }
}
