import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/viewmodel/user_viewmodel.dart';

class ToplulukUyeCard extends StatelessWidget {
  final Kullanici user;
  final int index;

  ToplulukUyeCard({required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 130,
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
            flex: 8,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(user.name!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                  Row(
                    children: [
                      Text(
                        "Rütbe: ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      user.rutbe != "Admin"
                          ? DropdownButton(
                              value: user.rutbe,
                              items: [
                                "Üye",
                                "Kariyer Üye(%10)",
                                "Kariyer Üye(%15)",
                                "Kariyer Üye(%21)",
                                "Kariyer Üye(%27)",
                                "Öncü",
                                "Bronz Öncü",
                                "Gümüş Öncü",
                                "Altın Öncü",
                                "Platin Öncü"
                              ]
                                  .map((label) => DropdownMenuItem(
                                        child: Text(label),
                                        value: label,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                _userModel.uyelerim[index].rutbe = value.toString();
                                _userModel.uyelerimGuncelle(user.userID!, value.toString());
                              },
                            )
                          : Container(),
                    ],
                  ),
                  Text(
                    "Üye No: " + user.uyeNo!,
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
                    value: user.bagimli!,
                    onChanged: (bool deger) {
                      _userModel.uyeBildirimiGuncelle(user.userID!, deger, index);
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
