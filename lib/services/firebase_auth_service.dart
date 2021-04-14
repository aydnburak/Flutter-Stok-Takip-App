import 'package:firebase_auth/firebase_auth.dart';
import 'package:stok_app/models/kullanici.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Kullanici?> currentUser() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return Kullanici(userID: user.uid);
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<Kullanici?> signInWithEmailAndPassword(String uyeNo, String sifre) async {
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: uyeNo + "admin@gmail.com", password: sifre);

    if (sonuc.user != null) {
      return Kullanici(userID: sonuc.user!.uid, email: sonuc.user!.email);
    } else {
      return null;
    }
  }

  Future<Kullanici?> createUserWithEmailAndPassword(String uyeNo, String sifre) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
        email: uyeNo + "admin@gmail.com", password: sifre);
    if (sonuc.user != null) {
      /*

      User? user = _firebaseAuth.currentUser;
      String? token = _firebaseAuth.currentUser!.refreshToken;
      _firebaseAuth.print("rgregrere" + user!.uid);
       */

      return Kullanici(userID: sonuc.user!.uid, email: sonuc.user!.email);
    } else {
      return null;
    }
  }

  Future<Kullanici?> addUye(
      String uyeNo, String sifre, String ustUyeEmail, String ustUyeS) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
        email: uyeNo + "admin@gmail.com", password: sifre);
    if (sonuc.user != null) {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: ustUyeEmail, password: ustUyeS);

      return Kullanici(userID: sonuc.user!.uid, email: sonuc.user!.email);
    } else {
      return null;
    }
  }
}
