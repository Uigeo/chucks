
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GameUser {
  final String uid;
  final String email;
  final int prize;
  final String imgUrl;
  final List<DocumentReference> gameHistory;
  GameUser( this.uid, this.email, this.prize, this.imgUrl, [this.gameHistory]);
}