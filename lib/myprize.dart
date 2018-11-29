import 'package:flutter/material.dart';

class MyPrizePage extends StatefulWidget {
  @override
  _MyPirzePageState createState() {
    return _MyPirzePageState();
  }

}

class _MyPirzePageState extends State<MyPrizePage> {

  int prize =3123;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),

      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("My Prize", style: TextStyle(fontSize: 30.0, fontFamily: 'SairaM' ),),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80.0,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 00.0),
                    height: 130.0,
                    width: 130.0,
                    decoration: BoxDecoration( color: Colors.amber , shape: BoxShape.circle),
                    child: Center(child: Text("C", style: TextStyle( color: Colors.white, fontSize: 80.0, fontFamily: 'SairaB', fontStyle: FontStyle.italic ),)),
                  ),
                  SizedBox(height: 30.0,),
                  Text(prize.toString() + " \$", style: TextStyle( color: Colors.black, fontSize: 40.0, fontFamily: 'SairaM', ),),
                  Text( "Cumulative  "+ prize.toString() + "\$", style: TextStyle( color: Colors.black, fontSize: 15.0, fontFamily: 'SairaL', ),),
                  SizedBox(height: 70.0,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          color: Colors.grey,
                          child: SizedBox(
                            height: 50.0,
                            child: Center(child: Text("Withdraw", style: TextStyle(color: Colors.white, fontSize: 20.0), )),),
                          onPressed: (){},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

}