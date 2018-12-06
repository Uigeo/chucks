
import 'package:cloud_firestore/cloud_firestore.dart';

class GameUser {
  DocumentReference ref;
  final String uid;
  final String email;
  final int prize;
  final int totalPrize;
  final String imgUrl;
  final String displayName;
  final String phone;
  GameUser( this.uid, this.email, this.prize, this.imgUrl, this.displayName, this.phone, this.totalPrize);


  GameUser.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, ref: snapshot.reference);

  GameUser.fromMap(Map<String, dynamic> map, {this.ref})
      : displayName = map['displayName'],
        prize = map['prize'],
        totalPrize = map['totalPrize'],
        email = map['email'],
        imgUrl = map['imgUrl'],
        uid = map['uid'],
        phone = map['phone'];
}

