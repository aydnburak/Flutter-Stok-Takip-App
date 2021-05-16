import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stok_app/models/depo_urun_list_model.dart';
import 'package:stok_app/models/depo_urun_model.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/models/sepet_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/services/db_base.dart';

import '../models/urun_model.dart';

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
          urunler.add(Urun.fromMap(tekUrun.data()));
        }
      } else {
        QuerySnapshot sonuc = await _firestore
            .collection("products")
            .where('tip1', isEqualTo: tip1)
            .where('tip2', isEqualTo: tip2)
            .get();

        for (QueryDocumentSnapshot tekUrun in sonuc.docs) {
          urunler.add(Urun.fromMap(tekUrun.data()));
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
        DocumentSnapshot documentSnapshot =
            await _firestore.collection('products').doc(tekFavori.data()!['urunID']).get();

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

  Future<List<Kullanici>> altUyeleriGetir(String userID) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("users").where('ustYetkiliID', isEqualTo: userID).get();
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

    await _firestore.collection("bildirim").doc(ustUser.userID).set({'durum': true});
  }

  Future<void> bildirimiKapat(String userID) async {
    await _firestore.collection("bildirim").doc(userID).set({'durum': false});
  }

  Future<List<Sepet>> getSepetlerim(String userID, bool durum) async {
    List<Sepet> mySepetlerim = [];

    QuerySnapshot querySnapshot;
    if (durum) {
      print("user id 1 :" + userID);
      querySnapshot = await _firestore
          .collection("sepetler")
          .where('userID', isEqualTo: userID)
          .orderBy('createdAt', descending: true)
          .get();
    } else {
      print("user id 1 :" + userID);
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
    QuerySnapshot querySnapshot =
        await _firestore.collection("sepetler").doc(sepetID).collection("sepetinUrunleri").get();
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await _firestore
          .collection("sepetler")
          .doc(sepetID)
          .collection("sepetinUrunleri")
          .doc(documentSnapshot.id)
          .delete();
    }
  }

  Future<void> onayla(String sepetID) async {
    await _firestore.collection("sepetler").doc(sepetID).update({'onay': true});
  }

  Future<void> tamamla(String sepetID) async {
    await _firestore.collection("sepetler").doc(sepetID).update({'tamamlandi': true});
  }

  Future<void> addSepetim(Urun urun, String userID) async {
    DocumentSnapshot gelenUrun = await _firestore
        .collection("sepetim")
        .doc(userID)
        .collection("urunlerim")
        .doc(urun.urunID)
        .get();

    if (gelenUrun.data() != null) {
      await _firestore
          .collection("sepetim")
          .doc(userID)
          .collection("urunlerim")
          .doc(urun.urunID)
          .update({'adet': urun.adet});
    } else {
      await _firestore
          .collection("sepetim")
          .doc(userID)
          .collection("urunlerim")
          .doc(urun.urunID)
          .set(urun.toMap2());
    }
  }

  Future<List<Urun>> getSepetim(String userID) async {
    List<Urun> sepetimdekiUrunler = [];
    QuerySnapshot gelenUrun =
        await _firestore.collection("sepetim").doc(userID).collection("urunlerim").get();
    for (DocumentSnapshot urun in gelenUrun.docs) {
      if (urun.data() != null) {
        sepetimdekiUrunler.add(Urun.fromMap2(urun.data()!));
      }
    }
    return sepetimdekiUrunler;
  }

  Future<void> allSepetimiSil(String userID) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("sepetim").doc(userID).collection("urunlerim").get();

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await _firestore
          .collection("sepetim")
          .doc(userID)
          .collection("urunlerim")
          .doc(documentSnapshot.id)
          .delete();
    }
  }

  Future<void> sepetUrunSil(String urunID, String userID) async {
    await _firestore.collection("sepetim").doc(userID).collection("urunlerim").doc(urunID).delete();
  }

  Future<void> sepetUrunAdetGuncelle(String userID, String urunID, int adet) async {
    await _firestore
        .collection("sepetim")
        .doc(userID)
        .collection("urunlerim")
        .doc(urunID)
        .update({'adet': adet});
  }

  Future<void> uyelerimGuncelle(String userID, String deger) async {
    await _firestore.collection("users").doc(userID).update({'rutbe': deger});
  }

  Future<void> addDepo1(DepoUrun depoUrun) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("stok")
        .where('urunID', isEqualTo: depoUrun.urunID)
        .where('userID', isEqualTo: depoUrun.userID)
        .where('createdAt', isEqualTo: depoUrun.createdAt)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      String id = querySnapshot.docs.first.id;
      int adet = querySnapshot.docs.first.data()['adet'] + depoUrun.adet!;
      _firestore.collection("stok").doc(id).update({'adet': adet});
    } else {
      await _firestore.collection("stok").doc().set(depoUrun.toMap());
    }
  }

  Future<List<DepoUrunList>> getDepo1(String userID) async {
    List<DepoUrunList> depoUrunListem = [];
    QuerySnapshot querySnapshot = await _firestore
        .collection("stok")
        .where('userID', isEqualTo: userID)
        .orderBy('createdAt')
        .get();

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      DepoUrun gelenDepoUrun = DepoUrun.fromMap(documentSnapshot.data()!);
      var sonuc =
          depoUrunListem.where((element) => element.depoUrun.urunID == gelenDepoUrun.urunID);
      if (sonuc.isNotEmpty) {
        //urun varsa
        int indexDegeri =
            depoUrunListem.indexWhere((element) => element.depoUrun.urunID == gelenDepoUrun.urunID);
        depoUrunListem[indexDegeri]
            .tarihlerim
            .add(TarihList(gelenDepoUrun.createdAt!, gelenDepoUrun.adet!));
      } else {
        //urun yoksa
        DepoUrunList depoUrunList = DepoUrunList(gelenDepoUrun);
        depoUrunList.tarihlerim.add(TarihList(gelenDepoUrun.createdAt!, gelenDepoUrun.adet!));
        depoUrunListem.add(depoUrunList);
      }
    }
    return depoUrunListem;
  }

  @override
  Future<void> deleteDepo1(String userID, String urunID, DateTime createdAt) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("stok")
        .where('urunID', isEqualTo: urunID)
        .where('userID', isEqualTo: userID)
        .where('createdAt', isEqualTo: createdAt)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      _firestore.collection("stok").doc(querySnapshot.docs.first.id).delete();
    }
  }

  Future<void> updateDepo1(String userID, String urunID, DateTime createdAt, int adet) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("stok")
        .where('urunID', isEqualTo: urunID)
        .where('userID', isEqualTo: userID)
        .where('createdAt', isEqualTo: createdAt)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      _firestore.collection("stok").doc(querySnapshot.docs.first.id).update({'adet': adet});
    }
  }
}
