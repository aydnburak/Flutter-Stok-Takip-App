import 'package:cloud_firestore/cloud_firestore.dart';

class Kullanici {
  final String? userID;
  String? uyeNo;
  String? email;
  String? name;
  String? rutbe;
  String? a;
  String? ustYetkiliID;
  String? ustUyeName;
  bool? bagimli;
  DateTime? createdAt;
  DateTime? updatedAt;

  @override
  String toString() {
    return 'Kullanici{userID: $userID, uyeNo: $uyeNo, email: $email, name: $name, rutbe: $rutbe, ustYetkiliID: $ustYetkiliID, ustUyeName: $ustUyeName, bagimli: $bagimli, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Kullanici(
      {required this.userID,
      this.uyeNo,
      this.email,
      this.name,
      this.rutbe,
      this.a,
      this.ustYetkiliID,
      this.ustUyeName,
      this.bagimli,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'uyeNo': uyeNo,
      'email': email,
      'name': name,
      'rutbe': rutbe,
      'a': a,
      'ustYetkiliID': ustYetkiliID,
      'ustUyeName': ustUyeName,
      'bagimli': bagimli ?? true,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  Kullanici.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        uyeNo = map['uyeNo'],
        email = map['email'],
        name = map['name'],
        rutbe = map['rutbe'],
        a = map['a'],
        ustYetkiliID = map['ustYetkiliID'],
        ustUyeName = map['ustUyeName'],
        bagimli = map['bagimli'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate();
}
