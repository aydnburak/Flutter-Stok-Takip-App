import 'package:get_it/get_it.dart';
import 'package:stok_app/repository/urun_repository.dart';
import 'package:stok_app/repository/user_repository.dart';
import 'package:stok_app/services/firebase_auth_service.dart';
import 'package:stok_app/services/firebase_storage_service.dart';
import 'package:stok_app/services/firestore_db_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => UrunRepository());
  locator.registerLazySingleton(() => FirebaseDbService());
  locator.registerLazySingleton(() => FirebaseStorageService());
}
