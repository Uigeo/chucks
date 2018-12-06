import 'dart:async';

import 'package:chucks/advertise.dart';
import 'package:chucks/auth_provider.dart';
import 'package:chucks/current_history.dart';
import 'package:chucks/game_start.dart';
import 'package:chucks/main.dart';
import 'package:chucks/model/user.dart';
import 'package:chucks/mypage.dart';
import 'package:chucks/notification.dart';
import 'package:chucks/rank.dart';
import 'package:chucks/victory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;
  AuthStatus authStatus = AuthStatus.notDetermined;

  Stream<QuerySnapshot> productSnapshot = Firestore.instance.collection('products').snapshots();

  Timer _timer;
  DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showPersBottomSheet;
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), _onTimeChange);
  }

  void _showPersBottomSheet(){
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState.showBottomSheet( (context) {
      return new Container(
        color: Colors.white,
        child: CurrentHistoryPage(),
      );
    } ).closed.whenComplete( (){
      if(mounted){
        setState(() {
          _showPersBottomSheetCallBack = _showPersBottomSheet;
        });
      }
    } );
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



  @override
  Widget build(BuildContext context) {
      GameUser user = AuthProvider.of(context).auth.gameUser;
      //if(user == null) return _buildWaitingScreen();

      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ const Color(0x88330867), const Color(0xFF30cfd0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0x00000000),
          appBar: AppBar(
            title: Text("CHUCKS", style: TextStyle(fontFamily: 'SairaB'),),
            centerTitle: false,
            backgroundColor: Color(0x00FFFFFF),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(icon:Icon(Icons.notifications), onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NotificationPage()));
              },),
              IconButton(icon: Icon(Icons.grade), onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RankPage()));
              },),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: _showBottomSheet,
              ),

              //SizedBox(width: 10.0,),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showPersBottomSheetCallBack,
            child: Icon(Icons.history, color: Colors.black87,),
            backgroundColor: Colors.white,
            mini: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _currentTime.hour.toString() + ' : ' + _currentTime.minute.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 50.0, fontFamily: 'SairaM',),
                ),
                Text(
                  'Be ready for the next battle',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontFamily: 'SairaL'
                  ),
                ),
                SizedBox(height: 30.0,),
                SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: GameStartButton( currentTime: _currentTime),
                ),
                SizedBox(height: 30.0,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: Center(child: SizedBox(
                    height: 100.0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(40.0, 0.0, 10.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage( user.imgUrl ?? "")

                                  )
                              )),
                          SizedBox(width: 15.0,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text( user.displayName ?? "NULL", style: TextStyle(fontFamily: 'SairaB', fontSize: 20.0),),
                                Text("Total Pirze " + user.prize.toString() + " \$" , style: TextStyle(fontFamily: 'SairaM', fontSize: 15.0), ),
                              ],
                            ),
                          ),
                          IconButton(icon: Icon(Icons.chevron_right), iconSize: 30.0 ,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_)=>MyPage() ));
                              }
                          )
                        ],
                      ),
                    ),
                  )
                  ),
                ),
              ],
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      );

  }

  void _showBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (b){
          return Container(

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(leading: Icon(Icons.description), title: Text('Rule') ,onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>VictoryPage()));
                },),
                ListTile(leading: Icon(Icons.help), title: Text('FAQ') ,onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AdvertisementPage(
                    gameRef: Firestore.instance.document('/games/-LT1U71esplK1luFdTaj')
                  )));
                },),
                ListTile(leading: Icon(Icons.exit_to_app), title: Text('Log Out') ,onTap: (){
                  AuthProvider.of(context).auth.singOut();
                  widget.onSignedOut();
                },),
                ListTile(leading: Icon(Icons.settings), title: Text('Preperence') ,onTap: (){},),
              ],
            ),
          );
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
