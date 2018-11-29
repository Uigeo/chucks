import 'package:cloud_firestore/cloud_firestore.dart';

class GameHistory {


  final DocumentReference ref;
  final DocumentReference gameRef;
  final int myFingers;
  final int prize;
  final int answer;
  final bool win;

  GameHistory.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, ref: snapshot.reference);

  GameHistory.fromMap(Map<String, dynamic> map, {this.ref})
      : gameRef = map['gameRef'],
        prize = map['prize'],
        win = map['win'],
        myFingers = map['imgUrl'],
        answer = map['answer'];
}