
import 'package:chucks/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {


  final VoidCallback onSignedIn;

  LoginPage({this.onSignedIn});

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        // Add box decoration
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.indigo[800],
              Colors.indigo[700],
              Colors.indigo[600],
              Colors.indigo[400],
            ],
          ),
        ),
        child: new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[


                Center(
                  child: Text(
                    "TWO",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "CHUCKS",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                new Padding(
                  padding: const EdgeInsets.all(20.0),
                ),
                new OutlineButton(
                    child: new Text(
                      "Sign In",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                      ),
                    ),
                    onPressed: () => AuthProvider.of(context).auth.signIn()
                        .then(
                            (FirebaseUser user) {
                          print(user);
                          Navigator.pop(context);
                        })
                        .catchError((e)=>print(e)),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                ),

                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
              ],
            )
        ),
      ),
    );
  }

}