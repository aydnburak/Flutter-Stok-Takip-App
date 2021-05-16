import 'package:stok_app/locator.dart';
import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/models/sepet_model.dart';
import 'package:stok_app/models/urun_model.dart';
import 'package:stok_app/services/firestore_db_service.dart';

class IslemRepository {
  FirebaseDbService _firebaseDbService = locator<FirebaseDbService>();

  Future<Kullanici?> getUstYetkili(Kullanici user) async {
    return await _firebaseDbService.getUstYetkili(user);
  }

  Future<void> sepetSave(Kullanici user, Kullanici ustUser, List<Urun> sepetim) async {
    await _firebaseDbService.sepetSave(user, ustUser, sepetim);
  }

  Future<void> bildirimiKapat(String userID) async {
    await _firebaseDbService.bildirimiKapat(userID);
  }

  Future<List<Sepet>> getSepetlerim(String userID, bool durum) async {
    return await _firebaseDbService.getSepetlerim(userID, durum);
  }

  Future<void> islemSepetDelete(String sepetID) async {
    await _firebaseDbService.islemSepetDelete(sepetID);
  }

  Future<void> onayla(String sepetID) async {
    await _firebaseDbService.onayla(sepetID);
  }

  Future<void> tamamla(String sepetID) async {
    await _firebaseDbService.tamamla(sepetID);
  }

  Future<void> addSepetim(Urun urun, String userID) async {
    await _firebaseDbService.addSepetim(urun, userID);
  }

  Future<List<Urun>> getSepetim(String userID) async {
    return await _firebaseDbService.getSepetim(userID);
  }

  Future<void> allSepetimiSil(String userID) async {
    await _firebaseDbService.allSepetimiSil(userID);
  }

  Future<void> sepetUrunSil(String urunID, String userID) async {
    await _firebaseDbService.sepetUrunSil(urunID, userID);
  }

  Future<void> sepetUrunAdetGuncelle(String userID, String urunID, int adet) async {
    await _firebaseDbService.sepetUrunAdetGuncelle(userID, urunID, adet);
  }
}
