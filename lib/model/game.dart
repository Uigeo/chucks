import 'package:chucks/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  DocumentReference ref;
  final DateTime start;
  final DateTime end;
  final int totalPrize;
  final int answer;
  final int winners;


  Game( this.start, this.totalPrize, this.answer, this.end, this.winners );


  Game.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, ref: snapshot.reference);

  Game.fromMap(Map<String, dynamic> map, {this.ref})
      : start = map['start'],
        end = map['end'],
        totalPrize = map['totalPrize'],
        answer = map['answer'],
        winners = map['winners'];
}