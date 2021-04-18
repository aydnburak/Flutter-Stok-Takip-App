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

  Future<List<Sepet>> getSepetlerim(String userID, bool durum) async {
    return await _firebaseDbService.getSepetlerim(userID, durum);
  }

  Future<void> islemSepetDelete(String sepetID) async {
    await _firebaseDbService.islemSepetDelete(sepetID);
  }
}
