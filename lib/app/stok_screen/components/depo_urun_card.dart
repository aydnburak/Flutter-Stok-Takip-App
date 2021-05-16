import 'package:flutter/material.dart';
import 'package:stok_app/app/stok_screen/components/card_top.dart';
import 'package:stok_app/app/stok_screen/components/date_detail.dart';
import 'package:stok_app/models/depo_urun_list_model.dart';

class DepoUrunCard extends StatefulWidget {
  final DepoUrunList depoUrunList;

  const DepoUrunCard({Key? key, required this.depoUrunList}) : super(key: key);

  @override
  _DepoUrunCardState createState() => _DepoUrunCardState();
}

class _DepoUrunCardState extends State<DepoUrunCard> {
  bool depoDetail = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)],
      ),
      child: Column(
        children: <Widget>[
          CardTop(
              depoUrunList: widget.depoUrunList,
              iconWidget: depoDetail == true ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPress: () {
                setState(() {
                  depoDetail = !depoDetail;
                });
              }),
          depoDetail == true
              ? Divider(
                  thickness: 1,
                  color: Colors.green,
                )
              : Container(),
          depoDetail == true ? DateDetail(depoUrunList: widget.depoUrunList) : Container(),
        ],
      ),
    );
  }
}
