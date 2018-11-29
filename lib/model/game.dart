import 'package:chucks/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  DocumentReference ref;
  final DateTime start;
  final int totalPrize;
  final int answer;
  List<DocumentReference> participants;
  List<GameUser> winners ;

  Game( this.start, this.totalPrize, this.participants, this.winners, this.answer );


  Game.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, ref: snapshot.reference);

  Game.fromMap(Map<String, dynamic> map, {this.ref})
      : start = map['start'],
        totalPrize = map['totalPrize'],
        answer = map['answer'];
}