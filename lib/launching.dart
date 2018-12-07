
import 'package:flutter/material.dart';

class LaunchingPage extends StatelessWidget {
  Animation<Color> s;

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
                CircularProgressIndicator(),
              ],
            )
        ),
      ),
    );
  }

}