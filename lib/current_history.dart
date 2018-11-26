import 'package:flutter/material.dart';

class GameInfo {
  final DateTime time;
  final int totlaprize;
  final int participants;
  final int winner;
  double prize;

  GameInfo( this.time, this.totlaprize, this.participants, this.winner ){
    this.prize = this.totlaprize / this.winner;
  }
}

List<GameInfo> sampledata = [
  GameInfo( DateTime(2018, 11, 15, 18, 02), 700, 200,4  ),
  GameInfo( DateTime(2018, 11, 15, 19, 05), 400, 120,3  ),
  GameInfo( DateTime(2018, 11, 15, 20, 10), 970, 300,7  ),
  GameInfo( DateTime(2018, 11, 15, 21, 22), 777, 120,11 ),
].toList();


class CurrentHistoryPage extends StatefulWidget {
  @override
  _CurrentHistoryPageState createState() {
    return _CurrentHistoryPageState();
  }

}

class _CurrentHistoryPageState extends State<CurrentHistoryPage> {


  @override
  Widget build(BuildContext context) {
    return Column(

        children: sampledata.map(
          (info) =>_buildHistoryTile(context, info)
        ).toList(),
    );
  }


  Widget _buildHistoryTile(BuildContext context, GameInfo info){
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('${info.time.year}.${info.time.month}.${info.time.day}', style: TextStyle( color: Colors.grey, fontFamily: 'SairaR', fontSize: 15.0 ), ),
                    Text('${info.time.hour}.${info.time.minute}', style: TextStyle( color: Colors.black87, fontFamily: 'SairaM', fontSize: 20.0 ),)
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
                    Text('Total Prize : ${info.totlaprize}', style: TextStyle( color: Colors.black87, fontFamily: 'SairaM', fontSize: 15.0 ), ),
                    Text('Participant : ${info.participants}', style: TextStyle( color: Colors.black87, fontFamily: 'SairaL', fontSize: 15.0 ), ),
                    Text('Winners : ${info.winner}', style: TextStyle( color: Colors.black87, fontFamily: 'SairaL', fontSize: 15.0 ), ),
                  ],
                ),
              ),
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