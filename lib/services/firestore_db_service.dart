import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/models/sepet_model.dart';
import 'package:stok_app/models/urun_model.dart';
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
      DocumentSnapshot documentSnapshot =
          await _firestore.collection("users").doc(kullanici.userID).get();
      if (documentSnapshot.data()!.isNotEmpty) {
        return Kullanici.fromMap(documentSnapshot.data()!);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<List<Urun>> getUrunler(String? tip1, String? tip2) async {
    List<Urun> urunler = [];
    if (tip1 != null) {
      if (tip2 == null) {
        QuerySnapshot sonuc =
            await _firestore.collection("products").where('tip1', isEqualTo: tip1).get();

        for (QueryDocumentSnapshot tekUrun in sonuc.docs) {
          urunler.add(Urun.fromMap(tekUrun.data()!));
        }
      } else {
        QuerySnapshot sonuc = await _firestore
            .collection("products")
            .where('tip1', isEqualTo: tip1)
            .where('tip2', isEqualTo: tip2)
            .get();

        for (QueryDocumentSnapshot tekUrun in sonuc.docs) {
          urunler.add(Urun.fromMap(tekUrun.data()!));
        }
      }
    }

    return urunler;
  }

  @override
  Future<void> addFavoriler(String userID, String urunID) async {
    await _firestore
        .collection("favoriler")
        .doc(userID + "--" + urunID)
        .set({'userID': userID, 'urunID': urunID});
  }

  @override
  Future<void> deleteFavoriler(String userID, String urunID) async {
    await _firestore.collection("favoriler").doc(userID + "--" + urunID).delete();
  }

  @override
  Future<List<Urun>> getFavoriler(String userID) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('favoriler').where('userID', isEqualTo: userID).get();

    List<Urun> urunler = [];
    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot tekFavori in querySnapshot.docs) {
        DocumentSnapshot documentSnapshot = await _firestore
            .collection('products')
            .doc(tekFavori.data()!['urunID'])
            .get();

        if (documentSnapshot.data() != null) {
          urunler.add(Urun.fromMap(documentSnapshot.data()!));
        }
      }
    }
    return urunler;
  }

  @override
  Future<bool> searchFavoriler(String userID, String urunID) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('favoriler').doc(userID + "--" + urunID).get();
    if (documentSnapshot.data() != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> addDepo(String userID, String urunID, int adet) async {
    await _firestore.collection("depo").doc(userID + "--" + urunID).set({
      'userID': userID,
      'urunID': urunID,
      'adet': adet,
    });
  }

  @override
  Future<void> deleteDepo(String userID, String urunID) async {
    await _firestore.collection("depo").doc(userID + "--" + urunID).delete();
  }

  @override
  Future<List<Urun>> getDepo(String userID) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('depo').where('userID', isEqualTo: userID).get();

    List<Urun> urunler = [];
    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot tekDepoUrun in querySnapshot.docs) {
        DocumentSnapshot documentSnapshot = await _firestore
            .collection('products')
            .doc(tekDepoUrun.data()!['urunID'])
            .get();

        if (documentSnapshot.data() != null) {
          Urun urun = Urun.fromMap(documentSnapshot.data()!);
          urun.adet = tekDepoUrun.data()!['adet'];
          urunler.add(urun);
        }
      }
    }
    return urunler;
  }

  @override
  Future<int> depoKontrol(Urun urun, String userID) async {
    int kacTane = 0;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("depo").doc(userID + "--" + urun.urunID!).get();
    if (documentSnapshot.data() != null) {
      kacTane = documentSnapshot.data()!['adet'];
    }

    return kacTane;
  }

  Future<void> depoGuncelle(String userID, String urunID, int selectedIndex) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("depo").doc(userID + "--" + urunID).get();
    if (documentSnapshot.data() != null) {
      int kacTane = documentSnapshot.data()!['adet'];
      await _firestore
          .collection("depo")
          .doc(userID + "--" + urunID)
          .update({'adet': kacTane + selectedIndex});
    }
  }

  Future<List<Kullanici>> altUyeleriGetir(String userID) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where('ustYetkiliID', isEqualTo: userID)
        .get();
    List<Kullanici> altUyeler = [];
    for (DocumentSnapshot kullanici in querySnapshot.docs) {
      altUyeler.add(Kullanici.fromMap(kullanici.data()!));
    }
    return altUyeler;
  }

  Future<void> uyeBildirimiGuncelle(String userID, bool deger) async {
    await _firestore.collection("users").doc(userID).update({'bagimli': deger});
  }

  Future<Kullanici?> getUstYetkili(Kullanici user) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(user.ustYetkiliID).get();

    if (documentSnapshot.data() != null) {
      return Kullanici.fromMap(documentSnapshot.data()!);
    } else {
      return null;
    }
  }

  Future<void> sepetSave(Kullanici user, Kullanici ustUser, List<Urun> sepetim) async {
    Sepet islemSepeti = Sepet();
    islemSepeti.userID = user.userID;
    islemSepeti.userName = user.name;
    islemSepeti.userNo = user.uyeNo;
    islemSepeti.ustUserID = ustUser.userID;
    islemSepeti.ustUserName = ustUser.name;
    islemSepeti.ustUserNo = ustUser.uyeNo;
    String sepetId = _firestore.collection("sepetler").doc().id;
    islemSepeti.sepetID = sepetId;
    await _firestore.collection("sepetler").doc(sepetId).set(islemSepeti.toMap());
    for (Urun urun in sepetim) {
      await _firestore
          .collection("sepetler")
          .doc(sepetId)
          .collection("sepetinUrunleri")
          .doc()
          .set({'urunID': urun.urunID, 'adet': urun.adet});
    }
    /*
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("sepetler").doc(sepetId).get();
    if (documentSnapshot.data() != null) {
      print('var');
    } else {
      print('yok');
    }
     */
  }

  Future<List<Sepet>> getSepetlerim(String userID, bool durum) async {
    List<Sepet> mySepetlerim = [];

    QuerySnapshot querySnapshot;
    if (durum) {
      querySnapshot = await _firestore
          .collection("sepetler")
          .where('userID', isEqualTo: userID)
          .orderBy('createdAt', descending: true)
          .get();
    } else {
      querySnapshot = await _firestore
          .collection("sepetler")
          .where('ustUserID', isEqualTo: userID)
          .orderBy('createdAt', descending: true)
          .get();
    }

    for (DocumentSnapshot sepet in querySnapshot.docs) {
      Sepet eklenecekSepet = Sepet.fromMap(sepet.data()!);
      QuerySnapshot querySnapshot = await _firestore
          .collection("sepetler")
          .doc(eklenecekSepet.sepetID)
          .collection("sepetinUrunleri")
          .get();
      List<Urun> urunlerim = [];
      for (DocumentSnapshot urunler in querySnapshot.docs) {
        DocumentSnapshot documentSnapshot =
            await _firestore.collection("products").doc(urunler.data()!['urunID']).get();
        Urun a = Urun.fromMap(documentSnapshot.data()!);
        a.adet = urunler.data()!['adet'];
        urunlerim.add(a);
      }
      eklenecekSepet.urunlerim = urunlerim;
      mySepetlerim.add(eklenecekSepet);
    }

    return mySepetlerim;
  }

  Future<void> islemSepetDelete(String sepetID) async {
    await _firestore.collection("sepetler").doc(sepetID).delete();
  }
}
