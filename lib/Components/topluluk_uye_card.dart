import 'package:flutter/material.dart';
import 'package:stok_app/models/kullanici.dart';

class ToplulukUyeCard extends StatefulWidget {
  final Kullanici user;

  ToplulukUyeCard({required this.user});

  @override
  _ToplulukUyeCardState createState() => _ToplulukUyeCardState();
}

class _ToplulukUyeCardState extends State<ToplulukUyeCard> {
  late Kullanici _user;

  @override
  void initState() {
    _user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Icon(
              Icons.person_outline,
              color: Colors.green,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _user.name!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "Rütbe: " + _user.rutbe!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Üye No: " + _user.uyeNo!,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("İstek Bildirimi"),
                  Switch(
                    value: _user.bagimli!,
                    onChanged: (bool deger) {
                      setState(() {
                        _user.bagimli = deger;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
