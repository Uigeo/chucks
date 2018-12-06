import 'package:chucks/model/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chucks/victory.dart';

class CurrentHistoryPage extends StatefulWidget {
  @override
  _CurrentHistoryPageState createState() {
    return _CurrentHistoryPageState();
  }

}

class _CurrentHistoryPageState extends State<CurrentHistoryPage> {


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Game>>(
        future: Firestore.instance.collection('games').orderBy('start', descending: true).limit(6).getDocuments().then(
            (query){ return query.documents.map( (snapshot){ return Game.fromSnapshot(snapshot); }  ).toList(); }
        ) ,
        builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot){
          return (snapshot.data == null) ? _buildWaiting() : Column(
            children: snapshot.data.map(
                    (game) =>_buildHistoryTile(context, game)
            ).toList(),
          );
        },

    );
  }

  Widget _buildWaiting() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }


  Widget _buildHistoryTile(BuildContext context, Game game){
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('${game.start.year}.${game.start.month}.${game.start.day}', style: TextStyle( color: Colors.grey, fontFamily: 'SairaR', fontSize: 15.0 ), ),
                    Text('${game.start.hour}.${game.start.minute}', style: TextStyle( color: Colors.black87, fontFamily: 'SairaM', fontSize: 20.0 ),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
                decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.teal.withOpacity(0.6), ))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Total Prize : ${game.totalPrize}', style: TextStyle( color: Colors.black87, fontFamily: 'SairaM', fontSize: 15.0 ), ),
                    Text('Each Prize : ${ (game.winners == null || game.winners == 0) ? 0 : (game.totalPrize / game.winners).round()}', style: TextStyle( color: Colors.black87, fontFamily: 'SairaL', fontSize: 15.0 ), ),
                    Text('Winners : ${game.winners}', style: TextStyle( color: Colors.black87, fontFamily: 'SairaL', fontSize: 15.0 ), ),
                  ],
                ),
              ),
              IconButton(icon: Icon(Icons.chevron_right, color: Colors.teal, ), onPressed: (){
                Navigator.of(context).push( MaterialPageRoute(builder: (_)=>VictoryPage(gameRef: game.ref,) ) );
              } )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(140.0, 22.0, 0.0, 0.0),
            child: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration( color: Colors.white, shape: BoxShape.circle, border: Border.all( color: Colors.teal ,width: 2.0) ),
            ),
          ),
        ],
      ),
    );
  }

}