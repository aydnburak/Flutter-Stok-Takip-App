import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Kullanici {
  final String? userID;
  String? uyeNo;
  String? email;
  String? name;
  String? rutbe;
  String? ustYetkiliID;
  bool? bagimli;
  DateTime? createdAt;
  DateTime? updatedAt;

  @override
  String toString() {
    return 'Kullanici{userID: $userID, uyeNo: $uyeNo, email: $email, name: $name, rutbe: $rutbe, ustYetkiliID: $ustYetkiliID, bagimli: $bagimli, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Kullanici(
      {required this.userID,
      this.uyeNo,
      this.email,
      this.name,
      this.rutbe,
      this.ustYetkiliID,
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
      'ustYetkiliID': ustYetkiliID,
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
        ustYetkiliID = map['ustYetkiliID'],
        bagimli = map['bagimli'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate();
}
