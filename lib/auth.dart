import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _firebaseAuth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

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