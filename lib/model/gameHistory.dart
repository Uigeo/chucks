import 'package:cloud_firestore/cloud_firestore.dart';

class GameHistory {


  final DocumentReference ref;
  final DocumentReference gameRef;
  final int fingers;
  final int answer;
  final bool win;

  GameHistory.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, ref: snapshot.reference);

  GameHistory.fromMap(Map<String, dynamic> map, {this.ref})
      : gameRef = map['gameRef'],
        win = map['win'],
        fingers = map['fingers'],
        answer = map['answer'];
}