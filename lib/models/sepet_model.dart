import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stok_app/models/urun_model.dart';

class Sepet {
  String? sepetID;
  String? userID;
  String? userNo;
  String? userName;
  String? ustUserID;
  String? ustUserNo;
  String? ustUserName;
  bool? onay;
  bool? tamamlandi;
  List<Urun>? urunlerim;
  DateTime? createdAt;
  DateTime? updatedAt;

  Sepet(
      {this.sepetID,
      this.userID,
      this.userNo,
      this.userName,
      this.ustUserID,
      this.ustUserNo,
      this.ustUserName,
      this.onay,
      this.tamamlandi,
      this.urunlerim,
      this.createdAt,
      this.updatedAt});

  @override
  String toString() {
    return 'Sepet{sepetID: $sepetID, userID: $userID, userNo: $userNo, userName: $userName, ustUserID: $ustUserID, ustUserNo: $ustUserNo, ustUserName: $ustUserName, onay: $onay, tamamlandi: $tamamlandi, urunlerim: $urunlerim, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Map<String, dynamic> toMap() {
    return {
      'sepetID': sepetID,
      'userID': userID,
      'userNo': userNo,
      'userName': userName,
      'ustUserID': ustUserID,
      'ustUserNo': ustUserNo,
      'ustUserName': ustUserName,
      'onay': onay ?? false,
      'tamamlandi': tamamlandi ?? false,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  Sepet.fromMap(Map<String, dynamic> map)
      : sepetID = map['sepetID'],
        userID = map['userID'],
        userNo = map['userNo'],
        userName = map['userName'],
        ustUserID = map['ustUserID'],
        ustUserNo = map['ustUserNo'],
        ustUserName = map['ustUserName'],
        onay = map['onay'],
        tamamlandi = map['tamamlandi'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate();
}
