import 'package:chucks/model/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameManager {


  void createGame(int totalPrize){
    Firestore.instance.collection('games').add({
      'time' : DateTime.now(),
      'totalPrize' : totalPrize,
    });
  }

  void addParticipant(DocumentReference game , DocumentReference user){
    Firestore.instance.document(game.path).collection('participants').add({
      'userRef' : user
    });
  }



}

