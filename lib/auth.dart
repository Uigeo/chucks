import 'dart:async';
import 'package:chucks/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final String defaultImgUrl = 'https://firebasestorage.googleapis.com/v0/b/chucks-da9d1.appspot.com/o/UserProfile%2Fcom.bandot.sagon.circle.darkiconpack.png?alt=media&token=db968de6-2709-4b5f-93a6-e189b18b2cf9';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  GameUser user;


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
                    'phone' : user.phoneNumber,
                    'email' : user.email,
                    'displayName' : user.displayName,
                    'imgUrl' : defaultImgUrl,
                    'prize' : 0,
                  });
                }
            );
          }

          print("Get User info");
          Future<QuerySnapshot> snapshot =  Firestore.instance.collection('users').where( 'uid', isEqualTo: user.uid ).getDocuments();
          snapshot.then(
                  (users){
                     this.user = GameUser.fromSnapshot(users.documents.elementAt(0));
                  //forEach(
//                        (key, v){
//                          print(key + " : "+ v.toString());
//                          if(key == 'uid') uid = v;
//                          else if(key == 'email') email = v;
//                          else if(key == 'displayName') displayName = v;
//                          else if(key == 'imgUrl') imgUrl = v;
//                          else if(key == 'prize') prize = v;
//                          else if(key == 'phone') phone = v;
//                        }
                  }
          );

        }
    );

    print("User Name: ${user.displayName}");
    return user;
  }

  Future<void> singOut(){
    googleSignIn.signOut();
    print("User Signed Out");
  }

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
}
