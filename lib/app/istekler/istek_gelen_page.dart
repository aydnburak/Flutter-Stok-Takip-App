import 'package:flutter/material.dart';

class IstekGelenPage extends StatefulWidget {
  @override
  _IstekGelenPageState createState() => _IstekGelenPageState();
}

class _IstekGelenPageState extends State<IstekGelenPage> {
  @override
  void initState() {
    print("istek Gelen Page Açıldı");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }
}
