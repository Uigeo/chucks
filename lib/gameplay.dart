import 'dart:async';

import 'package:chucks/advertise.dart';
import 'package:chucks/countdown.dart';
import 'package:chucks/model/game.dart';
import 'package:chucks/victory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class GamePlayPage extends StatefulWidget {
  final DocumentReference gameRef;
  final DocumentReference participantRef;
  GamePlayPage({Key key, this.gameRef, this.participantRef}) : super(key : key);

  @override
  _GamePlayPageState createState() {
    return _GamePlayPageState();
  }

}

class _GamePlayPageState extends State<GamePlayPage> {
  Timer _timer;
  Timer _endTimer;
  DateTime _currentTime;
  DateTime _startTime;
  Duration _remain;
  Game game;
  bool loading = true;

  TextEditingController _answerController = new TextEditingController(text: 0.toString());


  bool leftfold = true;
  bool rightfold =true;

  @override
  Widget build(BuildContext context) {

    widget.gameRef.snapshots().listen( (snapshot){
      game = Game.fromSnapshot(snapshot);
      _startTime = DateTime.now().add( game.end.difference(_currentTime));
      _remain = _startTime.difference(_currentTime);
      if(_remain.inSeconds < 0)_moveResult();
      this.loading = false;
    } );

    if(loading) return _buildWaitingScreen();
    else return _buildBody(context, game);
  }

  Widget _buildBody(BuildContext context, Game game){
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
                        _buildParticipantsNum(context, game)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (_remain.inSeconds <= 15) ? _buildCountDown(context) : _buildGameLogo(context, game),

            SizedBox(height: 20.0,),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      (_remain.inSeconds <= 15) ? _buildTextForm(context) :
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
    _timer = Timer.periodic(Duration(seconds: 1), _onTimeChange);
  }

  @override
  void dispose() {
    _timer.cancel();
    _endTimer.cancel();
    _answerController.dispose();
    super.dispose();
  }

  void _onTimeChange(Timer timer) {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  void _moveResult() async {
    print(widget.participantRef.path);
    print(_answerController.text);
    await Firestore.instance.document( widget.participantRef.path).updateData({
      'answer' : int.parse(this._answerController.text)
    });

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_)=>AdvertisementPage(gameRef: widget.gameRef)),
            (page){return page.isFirst;});
  }


  Widget _buildTextForm(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 250.0),
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
          controller: _answerController,
          style: TextStyle( fontFamily: 'SairaM', fontSize: 25.0, color: Colors.black87 ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: "Guess the number",
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
                leftfold = false;
              });
              changeAnswer(1);
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
          leftfold = true;
        });
        changeAnswer(-1);
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
              rightfold = false;
            });
            changeAnswer(1);
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
          rightfold = true;
        });
        changeAnswer(-1);
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

  changeAnswer(int a) async {
    Firestore.instance.runTransaction( (Transaction tx) async {
      DocumentSnapshot gameSnapshot = await tx.get(widget.gameRef);
      if(gameSnapshot.exists) {
        await tx.update(widget.gameRef, <String, dynamic>{'answer' : gameSnapshot.data['answer']+a});
      }
    });
  }

  Widget _buildAnswer(BuildContext context , Game game, int remainSecond){

          return (remainSecond % 30 ==0) ?
          Text(game.answer.toString(),
            style: TextStyle(color: Colors.white, fontSize: 50.0, fontFamily: 'SairaM',)
            ,) : Text( "XXXXX",
            style: TextStyle(color: Colors.white, fontSize: 50.0, fontFamily: 'SairaM',),
          );
  }

  Widget _buildCountDown(BuildContext context){
    return Column(
      children: <Widget>[
        CountDown(),
        SizedBox(height: 40.0,),
      ],
    );
  }

  Widget _buildGameLogo(BuildContext context, Game game ){

      final minutes = this._remain.inMinutes;
      final seconds = this._remain.inSeconds - this._remain.inMinutes*60;

      return Column(
        children: <Widget>[
          SizedBox(
              height: 50.0,
              width: 140.0,
              child: Text('${minutes} : ${seconds}', style: TextStyle(color: Colors.white, fontSize: 50.0, fontFamily: 'SairaM',),)
          ),
          SizedBox(height: 20.0,),
          Image.asset('assets/good.png',height: 120.0,),
          _buildAnswer(context, game, this._remain.inSeconds ),
        ],
      );

    }

  Widget _buildParticipantsNum(BuildContext context, Game game){
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection( game.ref.path  + '/participant').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          return Text( snapshot.data.documents.length.toString() , style: TextStyle(color: Colors.white, fontSize: 18.0),);
        }
      );
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

}

