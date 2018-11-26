
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GameUser {
  final FirebaseUser user;
  final int prize;
  final String imgUrl;
  final List<DocumentReference> gameHistory;
  GameUser( this.user, this.prize, this.imgUrl, this.gameHistory);
}