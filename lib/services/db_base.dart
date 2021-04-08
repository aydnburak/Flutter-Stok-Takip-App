import 'package:stok_app/models/kullanici.dart';
import 'package:stok_app/models/urun_model.dart';

abstract class DbBase {
  Future<Kullanici?> saveUser(Kullanici kullanici);
  Future<Kullanici?> readUser(String userID);
  Future<List<Urun?>?> getUrunler(String? tip1, String? tip2);
}
