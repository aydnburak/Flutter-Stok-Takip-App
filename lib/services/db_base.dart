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
  Future<List<Kullanici>> altUyeleriGetir(String userID);
  Future<void> uyeBildirimiGuncelle(String userID, bool deger);
}
