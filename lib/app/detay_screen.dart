import 'package:flutter/material.dart';
import 'package:stok_app/models/urun_model.dart';

class DetayScreen extends StatefulWidget {
  final UrunModel? urunListModel;

  DetayScreen({this.urunListModel});

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
                              tag: "${widget.urunListModel!.photoURL}",
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide()),
                                  image: DecorationImage(
                                    image: NetworkImage(widget.urunListModel!.photoURL!),
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
                                  "Kod:152",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("favladın");
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
                                      borderRadius: BorderRadius.all(Radius.circular(100)),
                                    ),
                                    child: Icon(
                                      Icons.favorite_border,
                                      //Icons.favorite,
                                      size: 30,
                                      //color: Colors.green,
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
                      Text("ÜRÜN ADI"),
                      Text("acıklama 1"),
                      Text("acıklama 2"),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, -1))],
              ),
              height: 60,
              child: Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Depoya Ekle")),
                  ElevatedButton(onPressed: () {}, child: Text("İsteğe Ekle")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
