import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/models/urun_model.dart';

abstract class DbBase {
  Future<Kullanici?> saveUser(Kullanici kullanici);
  Future<Kullanici?> readUser(String userID);
  Future<List<Urun?>?> getUrunler(String? tip1, String? tip2);
  Future<void> addFavoriler(String userID, String urunID);
  Future<void> deleteFavoriler(String userID, String urunID);
  Future<List<Urun>> getFavoriler(String userID);
  Future<bool> searchFavoriler(String userID, String urunID);
  Future<void> addDepo(String userID, String urunID, int adet);
  Future<void> deleteDepo(String userID, String urunID);
  Future<List<Urun>> getDepo(String userID);
  Future<int> depoKontrol(Urun urun, String userID);
  Future<void> depoGuncelle(String userID, String urunID, int selectedIndex);
}
