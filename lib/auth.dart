import 'dart:async';
import 'package:chucks/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final String defaultImgUrl = 'https://firebasestorage.googleapis.com/v0/b/chucks-da9d1.appspot.com/o/UserProfile%2Fcom.bandot.sagon.circle.darkiconpack.png?alt=media&token=db968de6-2709-4b5f-93a6-e189b18b2cf9';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  GameUser gameUser;

  Future<FirebaseUser> signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _firebaseAuth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    await Firestore.instance.collection('users').where('uid', isEqualTo:  user.uid).getDocuments().then(
        (e){
          if(e.documents.length == 0){
            print("New User");
            FirebaseAuth.instance.currentUser().then(
                    (user){
                  Firestore.instance.collection('users').add({
                    'uid' : user.uid,
                    'phone' : 'No phone',
                    'email' : user.email,
                    'displayName' : user.displayName,
                    'imgUrl' : defaultImgUrl,
                    'prize' : 0,
                    'totalPrzie' : 0
                  });
                }
            );
          }
        }
    );

    QuerySnapshot q = await Firestore.instance.collection('users').where('uid', isEqualTo:  user.uid).getDocuments();
    this.gameUser = GameUser.fromSnapshot(q.documents.first);


    print("User Name: ${this.gameUser.email}");
    return user;
  }


  Future<void> singOut(){
    googleSignIn.signOut();
    print("User Signed Out");
  }

  Future<String> currentUser() async {

    FirebaseUser user = await _firebaseAuth.currentUser();
    QuerySnapshot q = await Firestore.instance.collection('users').where('uid', isEqualTo:  user.uid).getDocuments();
    this.gameUser = GameUser.fromSnapshot(q.documents.first);
    return user?.uid;
  }
}
