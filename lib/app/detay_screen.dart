import 'package:flutter/material.dart';
import 'package:stok_app/Components/add_remove_button.dart';
import 'package:stok_app/models/urun_model.dart';

class DetayScreen extends StatefulWidget {
  final Urun? urun;

  DetayScreen({this.urun});

  @override
  _DetayScreenState createState() => _DetayScreenState();
}

class _DetayScreenState extends State<DetayScreen> {
  int selectedIndex = 1;
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
                              tag: "${widget.urun!.photoURL}",
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide()),
                                  image: DecorationImage(
                                    image: NetworkImage(widget.urun!.photoURL!),
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
                                      //selectedIndex = 1;
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(100)),
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
                  ElevatedButton(onPressed: () {}, child: Text("Depoya Ekle")),
                  ElevatedButton(onPressed: () {}, child: Text("Sepete Ekle")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
