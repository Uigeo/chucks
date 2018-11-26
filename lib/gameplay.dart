import 'dart:async';

import 'package:chucks/countdown.dart';
import 'package:flutter/material.dart';


class GamePlayPage extends StatefulWidget {

  @override
  _GamePlayPageState createState() {
    return _GamePlayPageState();
  }

}

class _GamePlayPageState extends State<GamePlayPage> {
  Timer _timer;
  DateTime _currentTime;
  DateTime _startTime;

  bool leftfold = false;
  bool rightfold =false;
  int thumbs = 2030;

  @override
  Widget build(BuildContext context) {

    
    final remaining = _startTime.difference(_currentTime);

    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds - remaining.inMinutes*60;


    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ const Color(0x88330867), const Color(0xFF30cfd0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("CHUCKS", style: TextStyle(fontFamily: 'SairaB', color: Colors.white, fontSize: 20.0),)),
                  Container(
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.all(Radius.circular(13.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person, color: Colors.white,),
                        Text(2134.toString(), style: TextStyle(color: Colors.white, fontSize: 18.0),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (remaining.inSeconds <= 15) ?
                    Column(
                      children: <Widget>[
                        CountDown(),
                        SizedBox(height: 40.0,),
                      ],
                    ) :
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                          width: 140.0,
                            child: Text('${minutes} : ${seconds}', style: TextStyle(color: Colors.white, fontSize: 50.0, fontFamily: 'SairaM',),)),
                        SizedBox(height: 20.0,),
                        Image.asset('assets/good.png',height: 120.0,),
                      ],
                    ),

            (remaining.inSeconds % 15 ==0) ?
            Text(thumbs.toString(), style: TextStyle(color: Colors.white, fontSize: 50.0, fontFamily: 'SairaM',),)
                : Text( "XXXXX", style: TextStyle(color: Colors.white, fontSize: 50.0, fontFamily: 'SairaM',),),
            SizedBox(height: 20.0,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    (remaining.inSeconds <= 15) ? _buildTextForm(context) :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildLeftThumb(context),
                        SizedBox(width: 30.0, height: 200.0,),
                        _buildRightThumb(context)
                      ],
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startTime = DateTime.now().add( Duration(minutes: 3) );
    _timer = Timer.periodic(Duration(seconds: 1), _onTimeChange);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onTimeChange(Timer timer) {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  DateTime calculateStartOfNextWeek(DateTime time) {

    return DateTime(time.minute+3, time.second );
  }

  Widget _buildTextForm(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 350.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            blurRadius: 20.0,
            offset: Offset(3.0, 3.0)
          )]
        ),
        width : 340.0,
        child: TextFormField(
          autofocus: true,
          style: TextStyle( fontFamily: 'SairaM', fontSize: 25.0, color: Colors.black87 ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: "Gusse the number",
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide( color: Colors.grey, width: 3.0 )
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  )

              )
          ),
        ),
      ),
    );
  }

  Widget _buildLeftThumb(BuildContext context){
    return leftfold ?
      Column(
        children: <Widget>[
          SizedBox(height: 100.0),
          InkWell(
            onTap: (){
              setState(() {
                thumbs += 1;
                leftfold = false;
              });
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 120.0,
                  decoration: BoxDecoration( color: Color(0xFFFFF8E6) ,borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft:  Radius.circular(30.0) ) ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 80.0, 15.0, 0.0),
                  child: Container(

                    width: 90.0,
                    decoration: BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide( color: Colors.grey, width: 4.0 ),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 60.0, 15.0, 0.0),
                  child: Container(

                    width: 90.0,
                    decoration: BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide( color: Colors.grey, width: 4.0 ),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
      :
      InkWell(
      onTap: (){
        setState(() {
          thumbs -= 1;
          leftfold = true;
        });
        },
      child: Stack(
        children: <Widget>[
          Container(
            height: 250.0,
            width: 120.0,
            decoration: BoxDecoration( color: Color(0xFFFFF8E6) ,borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft:  Radius.circular(30.0) ) ),
          ),
         Padding(
           padding: const EdgeInsets.all(15.0),
           child: Container(

             height: 100.0,
             width: 90.0,
             decoration: BoxDecoration( color: Color(0xFFFFA9A9) ,borderRadius: BorderRadius.all( Radius.circular(13.0) ) ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.fromLTRB(15.0, 180.0, 15.0, 0.0),
           child: Container(

             width: 90.0,
             decoration: BoxDecoration(
               border: BorderDirectional(
                 bottom: BorderSide( color: Colors.grey, width: 4.0 ),
               )
             ),
           ),
         ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 200.0, 15.0, 0.0),
            child: Container(

              width: 90.0,
              decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide( color: Colors.grey, width: 4.0 ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightThumb(BuildContext context){
    return rightfold ?
    Column(
      children: <Widget>[
        SizedBox(height: 100.0,),
        InkWell(
          onTap: (){
            setState(() {
              thumbs += 1;
              rightfold = false;
            });
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: 150.0,
                width: 120.0,
                decoration: BoxDecoration( color: Color(0xFFFFF8E6) ,borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft:  Radius.circular(30.0) ) ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 80.0, 15.0, 0.0),
                child: Container(

                  width: 90.0,
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide( color: Colors.grey, width: 4.0 ),
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 60.0, 15.0, 0.0),
                child: Container(

                  width: 90.0,
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide( color: Colors.grey, width: 4.0 ),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        :
    InkWell(
      onTap: (){
        setState(() {
          thumbs -= 1;
          rightfold = true;
        });
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: 250.0,
            width: 120.0,
            decoration: BoxDecoration( color: Color(0xFFFFF8E6) ,borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft:  Radius.circular(30.0) ) ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(

              height: 100.0,
              width: 90.0,
              decoration: BoxDecoration( color: Color(0xFFFFA9A9) ,borderRadius: BorderRadius.all( Radius.circular(13.0) ) ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 180.0, 15.0, 0.0),
            child: Container(

              width: 90.0,
              decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide( color: Colors.grey, width: 4.0 ),
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 200.0, 15.0, 0.0),
            child: Container(

              width: 90.0,
              decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide( color: Colors.grey, width: 4.0 ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

}