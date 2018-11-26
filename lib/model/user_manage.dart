
import 'dart:async';

import 'package:chucks/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManager {

  final String defaultImgUrl = 'https://firebasestorage.googleapis.com/v0/b/chucks-da9d1.appspot.com/o/UserProfile%2Fcom.bandot.sagon.circle.darkiconpack.png?alt=media&token=db968de6-2709-4b5f-93a6-e189b18b2cf9';

  Future<DocumentReference> newUser(FirebaseUser user){
    FirebaseAuth.instance.currentUser().then(
        (user){
          return Firestore.instance.collection('users').add({
            'FirebaseUser' : user,
            'displayName' : user.displayName,
            'imgUrl' : defaultImgUrl,
            'prize' : 0,
          });
        }
    );
  }

  void updateUser(DocumentReference user,  String imgUrl){
    Firestore.instance.document(user.path).updateData({
      'imgUrl' : imgUrl,
    });
  }

  void joinGame(DocumentReference game, DocumentReference user){
    Firestore.instance.document(user.path).collection('gameHistory').add({
      'gameRef': game,
      'fingers' : 0,
      'answer' : 0,
    });
  }

  void updateFinger(DocumentReference currentGame, int finger){
    Firestore.instance.document(currentGame.path).updateData({
      'fingers' : finger
    });
  }
}
