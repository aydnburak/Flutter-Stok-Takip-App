import 'package:stok_app/locator.dart';
import 'package:stok_app/services/firebase_auth_service.dart';
import 'package:stok_app/services/firebase_storage_service.dart';
import 'package:stok_app/services/firestore_db_service.dart';

class UserRepository {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FirebaseDbService _firebaseDbService = locator<FirebaseDbService>();
  FirebaseStorageService _firebaseStorageService = locator<FirebaseStorageService>();
}
