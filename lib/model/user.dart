
import 'package:cloud_firestore/cloud_firestore.dart';

class GameUser {
  DocumentReference ref;
  final String uid;
  final String email;
  final int prize;
  final String imgUrl;
  final String displayName;
  final String phone;
  GameUser( this.uid, this.email, this.prize, this.imgUrl, this.displayName, this.phone);


  GameUser.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, ref: snapshot.reference);

  GameUser.fromMap(Map<String, dynamic> map, {this.ref})
      : displayName = map['name'],
        prize = map['prize'],
        email = map['email'],
        imgUrl = map['imgUrl'],
        uid = map['uid'],
        phone = map['phone'];
}

