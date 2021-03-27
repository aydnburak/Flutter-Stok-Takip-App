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

  Future<Kullanici?> signInWithEmailAndPassword(String email, String sifre) async {
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);

    if (sonuc.user != null) {
      return Kullanici(userID: sonuc.user!.uid, email: sonuc.user!.email);
    } else {
      return null;
    }
  }

  Future<Kullanici?> createUserWithEmailAndPassword(String email, String sifre) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
    if (sonuc.user != null) {
      return Kullanici(userID: sonuc.user!.uid, email: sonuc.user!.email);
    } else {
      return null;
    }
  }
}
