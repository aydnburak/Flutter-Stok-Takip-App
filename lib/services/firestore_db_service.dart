import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/services/db_base.dart';

class FirebaseDbService implements DbBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Kullanici?> readUser(String userID) async {
    DocumentSnapshot _okunanUser = await _firestore.collection("users").doc(userID).get();

    if (_okunanUser.data() != null) {
      return Kullanici.fromMap(_okunanUser.data()!);
    } else {
      return null;
    }
  }

  @override
  Future<Kullanici?> saveUser(Kullanici kullanici) async {
    var sonuc = await _firestore.collection("users").doc(kullanici.userID).get();
    if (sonuc.data() == null) {
      await _firestore.collection("users").doc(kullanici.userID).set(kullanici.toMap());
      DocumentSnapshot documentSnapshot = await _firestore.collection("users").doc(kullanici.userID).get();
      if (documentSnapshot.data()!.isNotEmpty) {
        return Kullanici.fromMap(documentSnapshot.data()!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
