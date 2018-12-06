import 'package:chucks/model/game.dart';
import 'package:chucks/model/participant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class VictoryPage extends StatefulWidget {
  final DocumentReference gameRef;
  VictoryPage({Key key, this.gameRef}) : super(key: key);

  @override
  _VictoryPageState createState() {
    return _VictoryPageState();
  }
}

class _VictoryPageState extends State<VictoryPage>{
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Game>(
      future: widget.gameRef.get().then( (snapshot){return Game.fromSnapshot(snapshot); } ),
      builder: (BuildContext context, AsyncSnapshot<Game> snapshot){
        return ( snapshot.data == null ) ? _buildWaitingScreen()
        : Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ const Color(0x88330867), const Color(0xFF30cfd0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
          child: _buildFutureScaffold(context, snapshot.data)
        );
      },
    );


  }


  Widget _buildWinnersListView(BuildContext context, List<Participant> participants ) {
    return ListView.builder(
        itemCount: participants.length,
        scrollDirection: Axis.horizontal,

        itemBuilder: (_, index){
          return _buildWinnerListTile(_, participants[index]);
          },
        shrinkWrap: true,
    );
  }

  Widget _buildWinnerListTile(BuildContext context, Participant user){
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 30.0, 0.0),
      width: 120.0,
      height: 120.0,
      child: Column(
        children: <Widget>[
          _buildCircleImage(context, user.imgUrl),
          _buildNameText(context, user.displayName)
        ],
      ),
    );
  }
  
  Widget _buildCircleImage(BuildContext context, String url){
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.contain)
      ),
    );
  }

  Widget _buildNameText(BuildContext context, String name){
    return Container(
      alignment: Alignment.center,
      height: 30.0,
      width: 75.0,
      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Text(name, style: TextStyle(color: Colors.white, fontFamily: 'SairaM', fontSize: 12.0),),
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

  Widget _buildFutureScaffold(BuildContext context, Game game) {
    return FutureBuilder<List<Participant>>(
      future: Firestore.instance.collection( widget.gameRef.path + '/participant' ).getDocuments().then(
              (event){return event.documents.map( (snapshot){return Participant.fromSnapshot(snapshot);} ).toList();} ),
      builder: (BuildContext context, AsyncSnapshot<List<Participant>> snapshot ){
        return (snapshot.data == null) ? Container() : Scaffold(
          backgroundColor: Color(0x00000000),
          body: Column(
            children: <Widget>[
              SizedBox(height: 40.0,),
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
                          Text(snapshot.data.length.toString(), style: TextStyle(color: Colors.white, fontSize: 18.0),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0,),
              Container(
                  width: 80.0,
                  decoration: BoxDecoration( color: Colors.white30 , borderRadius: BorderRadius.all(Radius.circular(13.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.stars, color: Colors.amberAccent,),
                      Text( snapshot.data.where( (p){ return p.win;} ).length.toString() ?? '0' , style: TextStyle(color: Colors.amberAccent, fontSize: 20.0),)
                    ],
                  )
              ),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 00.0),
                height: 180.0,
                width: 180.0,
                decoration: BoxDecoration( color: Colors.amber , shape: BoxShape.circle,
                    boxShadow: [BoxShadow(offset: Offset(4.0, 4.0), blurRadius: 10.0 )]
                ),

                child: Center(child: Text( game.totalPrize.toString() +" \$", style: TextStyle( color: Colors.white, fontSize: 50.0, fontFamily: 'SairaB', fontStyle: FontStyle.italic ),)),
              ),
              SizedBox(height: 20.0,),
              Container(
                  width: 150.0,
                  decoration: BoxDecoration( color: Colors.white30 , borderRadius: BorderRadius.all(Radius.circular(13.0))),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Each : ", style: TextStyle(color: Colors.amberAccent, fontSize: 20.0),),

                          Text( (game.winners == null || game.winners == 0) ? 0.toString() : (game.totalPrize/game.winners).round().toString() +"\$", style: TextStyle(color: Colors.amberAccent, fontSize: 20.0),),

                        ],
                      ),
                    ],
                  )
              ),
              SizedBox(height: 60.0,),
              Container(
                  alignment: AlignmentDirectional.center ,
                  width: double.infinity,
                  height: 225.0,
                  child: _buildWinnersListView(context, snapshot.data.where( (p){return p.win;} ).toList()))
            ],
          ),
        );
    },
    );
  }
}