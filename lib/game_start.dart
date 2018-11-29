import 'package:chucks/auth_provider.dart';
import 'package:chucks/gameplay.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.pinkAccent,
      onPressed:  gameCreated ? gameStarting ? (){ Navigator.of(context).push( MaterialPageRoute(builder: (_)=>GamePlayPage()) ); }
                      : null
          : (){
            _createGame();
            Navigator.of(context).push( MaterialPageRoute(builder: (_)=>GamePlayPage()) );
            },
      child: widget.currentTime.minute < 1 ? Text('Waiting', style: TextStyle(
          fontFamily: 'SairaR',
          color: Colors.white,
          fontSize: 18.0
      ),
      ) : Text('Let Go', style: TextStyle(
          fontFamily: 'SairaR',
          color: Colors.white,
          fontSize: 18.0
      ),
      ),
    );
  }

  _createGame() async {
    await Firestore.instance.collection('games').add(
      {
        'start' : DateTime.now(),
        'end' : DateTime.now().add(Duration(minutes: 3)),
        'hostuid' : AuthProvider.of(context).auth.user.uid,
        'participant' : [],
        'winner' : [],
      }
    );
  }

}