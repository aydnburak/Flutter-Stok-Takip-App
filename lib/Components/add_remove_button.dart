import 'package:flutter/material.dart';

class AddRemoveButton extends StatelessWidget {
  final double? height;
  final double? width;
  final int? value;
  final VoidCallback? remove;
  final VoidCallback? add;

  AddRemoveButton({this.height = 40, this.width = 100, this.value = 1, this.remove, this.add});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(3),
      decoration:
          BoxDecoration(border: Border.all(width: 0.5), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FloatingActionButton(
              heroTag: "btn1",
              elevation: 0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.remove,
                color: Colors.black,
              ),
              onPressed: remove,
            ),
          ),
          Expanded(
              child: Center(
                  child: Text(
            value!.toString(),
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ))),
          Expanded(
            child: FloatingActionButton(
              heroTag: "btn2",
              elevation: 0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: add,
            ),
          ),
        ],
      ),
    );
  }
}
