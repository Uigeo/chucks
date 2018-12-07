
import 'package:chucks/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {

  LoginPage({this.onSignedIn, this.loading});
  final VoidCallback onSignedIn;
  final VoidCallback loading;

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white.withOpacity(0.0),
      body: Container(
        // Add box decoration
        decoration: BoxDecoration(
      gradient: LinearGradient(
      colors: [ const Color(0x88330867), const Color(0xFF30cfd0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    )
    ),
        child: new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                SizedBox(height: 20.0,),
                Image.asset("good.png", height: 120.0,),

                Center(
                  child: Text(
                    "CHUCKS",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 45.0,
                      fontFamily: 'SairaB',
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                new Padding(
                  padding: const EdgeInsets.all(20.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: new OutlineButton(

                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 20.0,),
                          Text(
                            "Sign In with Google",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'SairaM',
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      onPressed: (){
                        widget.loading();
                        AuthProvider.of(context).auth.signIn()
                            .then(
                                (FirebaseUser user) {
                              print(user);
                              widget.onSignedIn();
                            })
                            .catchError((e)=>print(e));
                      },
                      shape: BeveledRectangleBorder()
                  ),
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