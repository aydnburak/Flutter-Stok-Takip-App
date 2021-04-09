import 'package:stok_app/locator.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/services/firestore_db_service.dart';

class UrunRepository {
  FirebaseDbService _firebaseDbService = locator<FirebaseDbService>();
  List<Urun> localUrunler = [];

  Future<List<Urun>> getUrunler(String? tip1, String? tip2) async {
    List<Urun> lUrunler = _listedeUrunleriAra(tip1, tip2);
    if (lUrunler.isNotEmpty) {
      print("localden gelen urunler");
      return lUrunler;
    } else {
      print("dbden gelen urunler");
      List<Urun> dbGelenUrunler = await _firebaseDbService.getUrunler(tip1, tip2);
      if (dbGelenUrunler.isNotEmpty) {
        for (Urun urun in dbGelenUrunler) {
          localUrunler.add(urun);
        }
      }
      return dbGelenUrunler;
    }
  }

  List<Urun> _listedeUrunleriAra(String? tip1, String? tip2) {
    List<Urun> urunler = [];
    for (Urun urun in localUrunler) {
      if (urun.tip1 == tip1) {
        if (urun.tip2 == tip2) {
          urunler.add(urun);
        } else if (tip2 == null) {
          urunler.add(urun);
        }
      }
    }
    return urunler;
  }

  Future<void> addFavoriler(String userID, String urunID) async {
    await _firebaseDbService.addFavoriler(userID, urunID);
  }

  Future<void> deleteFavoriler(String userID, String urunID) async {
    await _firebaseDbService.deleteFavoriler(userID, urunID);
  }

  Future<bool> searchFavoriler(String userID, String urunID) async {
    return await _firebaseDbService.searchFavoriler(userID, urunID);
  }

  Future<List<Urun>> getFavoriler(String userID) async {
    return await _firebaseDbService.getFavoriler(userID);
  }
}
