import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Participant {
  DocumentReference ref;
  final int answer;
  final DocumentReference userRef;
  final bool win;
  final String imgUrl;
  final String displayName;

  Participant( this.answer, this.userRef, this.win , this.displayName, this.imgUrl);

  Participant.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, ref: snapshot.reference);

  Participant.fromMap(Map<String, dynamic> map, {this.ref})
      : answer = map['answer'],
        userRef = map['userRef'],
        win = map['win'],
        imgUrl = map['imgUrl'],
        displayName = map['displayName'];
}