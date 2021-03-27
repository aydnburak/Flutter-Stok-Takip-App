import 'package:stok_app/models/kullanici.dart';

abstract class DbBase {
  Future<Kullanici?> saveUser(Kullanici kullanici);
  Future<Kullanici?> readUser(String userID);
}
