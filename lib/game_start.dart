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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime date = DateTime( widget.currentTime.year, widget.currentTime.month, widget.currentTime.day, widget.currentTime.hour,);

    Firestore.instance.collection('games').where('start', isGreaterThan: date).getDocuments().then(
        (query){
          if(query.documents.length != 0) gameCreated = true;
          else {
            gameCreated = false;
            Game game = Game.fromSnapshot(query.documents.first);
            if(game.start.difference(widget.currentTime).inSeconds > 180) gameStarting = false;
            else gameStarting = true;
          }




        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.pinkAccent,
      onPressed:  gameCreated ? gameStarting ? _moveToGame() : null : _createGame(),
      child: gameCreated ? gameStarting ? _textGoGame() : _textWaiting() : _textCreateGame(),
    );
  }

  _createGame() async {
    GameUser user = AuthProvider.of(context).auth.gameUser;
    await Firestore.instance.collection('games').add(
      {
        'start' : DateTime.now(),
        'end' : DateTime.now().add(Duration(minutes: 3)),
        'hostuid' : user.uid,
        'participant' : <DocumentReference>[user.ref],
        'winner' : [],
      }
    );
    Navigator.of(context).push( MaterialPageRoute(builder: (_)=>GamePlayPage()) );
  }

  _moveToGame(){
    Navigator.of(context).push( MaterialPageRoute(builder: (_)=>GamePlayPage()) );
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