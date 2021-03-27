import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  Widget _buildItemList(BuildContext context, int index) {
    if (index == data.length)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Container(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.yellow,
            width: 150,
            height: 200,
            child: Center(
              child: Text(
                '${data[index]}',
                style: TextStyle(fontSize: 50.0, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _userModel.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          IconButton(
              icon: Icon(Icons.account_box),
              onPressed: () {
                print(_userModel.kullanici.toString());
              }),
          Text(_userModel.kullanici!.email!),
          Text(_userModel.kullanici!.name!),
          Text(_userModel.kullanici!.userID!),
          Expanded(
              child: ScrollSnapList(
            itemBuilder: _buildItemList,
            itemSize: 150,
            dynamicItemSize: true,
            onReachEnd: () {
              print('Done!');
            },
            itemCount: data.length,
            onItemFocus: (int) {
              print('deger : ' + int.toString());
            },
          )),
        ],
      ),
    );
  }
}
