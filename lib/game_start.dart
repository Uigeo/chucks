import 'package:chucks/auth_provider.dart';
import 'package:chucks/gameplay.dart';
import 'package:chucks/model/game.dart';
import 'package:chucks/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class GameStartButton extends StatefulWidget {
  final DateTime currentTime;
  GameStartButton({Key key, this.currentTime}) : super(key: key);

  @override
  _GameStartButtonState createState() {
    return _GameStartButtonState();
  }

}

class _GameStartButtonState extends State<GameStartButton> {

  bool gameStarting = false;
  bool gameCreated = false;
  DateTime date;
  Game game;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
//    print("Created : " + gameCreated.toString()+ "  "+  widget.currentTime.toString());
//    print("Starting : " + gameStarting.toString() );



    return StreamBuilder<DateTime>(
        stream: Firestore.instance.collection('games').limit(1).orderBy('start', descending: true).snapshots().map(
                (event){ return event.documents.first.data['start']; }
        ),
        builder: (BuildContext context, AsyncSnapshot<DateTime> snapshot){


          this.date = DateTime( widget.currentTime.year, widget.currentTime.month, widget.currentTime.day, widget.currentTime.hour,0,0);

          if(snapshot.data == null) return CircularProgressIndicator();
          else {
            DateTime gameTime = DateTime(snapshot.data.year, snapshot.data.month, snapshot.data.day, snapshot.data.hour,0,0);

            if(this.date.difference(gameTime).inHours < 1){
              gameCreated = true;
            }
            else {
              gameCreated = false;
            }

            if(snapshot.data.difference(widget.currentTime).inSeconds < -180) gameStarting = false;
            else gameStarting = true;

            return RaisedButton(
              color: Colors.pinkAccent,
              onPressed:  gameCreated ? gameStarting ? (){ _moveToGame();} : null : (){_createGame();},
              child: gameCreated ? gameStarting ? _textGoGame() : _textWaiting() : _textCreateGame(),
            );
          }
        }
    );


  }

  void _createGame() async {
    GameUser user = AuthProvider.of(context).auth.gameUser;
    DocumentReference gameRef = await Firestore.instance.collection('games').add(
      {
        'start' : DateTime.now(),
        'end' : DateTime.now().add(Duration(minutes: 3)),
        'totalPrize' : 400,
        'hostuid' : user.uid,
        'answer' : 0,
        'winners' : 0
      }
    );
    DocumentReference partRef = await Firestore.instance.document(gameRef.path).collection('participant').add({
      'userRef' : user.ref,
      'win' : false,
      'answer' : 0,
      'displayName' : user.displayName,
      'imgUrl' : user.imgUrl,
    });

    Firestore.instance.document(user.ref.path).collection('history').add(
      {
        'gameRef' : gameRef,
        'fingers' : 0,
        'win' : false,
      }
    );

    Navigator.of(context).push( MaterialPageRoute(builder: (_)=>GamePlayPage( gameRef: gameRef, participantRef: partRef,)) );
  }

  void _moveToGame() async {

    GameUser user = AuthProvider.of(context).auth.gameUser;

    QuerySnapshot query = await Firestore.instance.collection('games').limit(1).orderBy('start', descending: true).snapshots().first;
    DocumentReference gameRef = query.documents.first.reference;

    DocumentReference partRef = await Firestore.instance.collection( gameRef.path + '/participant').add(
      {
        'userRef' : user.ref,
        'win' : false,
        'answer' : 0,
        'displayName' : user.displayName,
        'imgUrl' : user.imgUrl,
      }
    );
    Firestore.instance.collection( user.ref.path + '/history').add(
        {
          'gameRef' : gameRef,
          'fingers' : 0,
          'win' : false,
        }
    );
    Navigator.of(context).push( MaterialPageRoute(builder: (_)=>GamePlayPage( gameRef: gameRef, participantRef: partRef, )) );
  }


  Widget _textWaiting(){
    return Text('Waiting', style: TextStyle(
        fontFamily: 'SairaR',
        color: Colors.white,
        fontSize: 18.0
    ),
    );
  }

  Widget _textCreateGame(){
    return Text('Create Game', style: TextStyle(
        fontFamily: 'SairaR',
        color: Colors.white,
        fontSize: 18.0
      ),
    );
  }

  Widget _textGoGame(){
    return Text("Let's go", style: TextStyle(
        fontFamily: 'SairaR',
        color: Colors.white,
        fontSize: 18.0
    ),
    );
  }





}