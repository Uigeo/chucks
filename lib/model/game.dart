import 'package:chucks/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  final DateTime time;
  final int totalPrize;
  final List<DocumentReference> participants;
  final List<GameUser> winners ;
  double prize;


  Game( this.time, this.totalPrize, this.participants, this.winners ){
    this.prize = this.totalPrize / this.winners.length;
  }
}