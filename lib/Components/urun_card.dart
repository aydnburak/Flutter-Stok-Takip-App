import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stok_app/app/detay_screen.dart';
import 'package:stok_app/models/urun_model.dart';

class UrunCard extends StatelessWidget {
  final UrunModel? urunModel;

  UrunCard({this.urunModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetayScreen(
              urunListModel: urunModel,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, -1), blurRadius: 10)],
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kod:" + urunModel!.kod!,
                    style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey.shade600),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, -1))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        //Icons.favorite,
                        //color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Hero(
                      tag: "${urunModel!.photoURL!}",
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(urunModel!.photoURL!),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              child: Center(
                child: AutoSizeText(
                  "${urunModel!.name}",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
