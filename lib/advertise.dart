import 'dart:async';

import 'package:chucks/model/game.dart';
import 'package:chucks/smallcountdown.dart';
import 'package:chucks/victory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdvertisementPage extends StatefulWidget {
  final DocumentReference gameRef;
  AdvertisementPage({ Key key, this.gameRef} ) : super(key : key);

  @override
  _AdvertisementPageState createState() {
    return _AdvertisementPageState();
  }

}

class _AdvertisementPageState extends State< AdvertisementPage> {

  final String advertize = "https://firebasestorage.googleapis.com/v0/b/chucks-da9d1.appspot.com/o/UserProfile%2FKakaoTalk_Photo_2018-12-06-12-22-44.png?alt=media&token=8bb43073-7b92-4a83-89dc-68493520ee65";

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [  const Color(0xFF0093E9),const Color(0xFF80D0C7), ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0.0),
          body: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Text('유료광고', style: TextStyle( fontSize: 20.0, fontFamily: 'SairaB', color: Colors.white ),),
                    SizedBox(height: 80.0,),

                    Image.network("https://firebasestorage.googleapis.com/v0/b/chucks-da9d1.appspot.com/o/thumb.png?alt=media&token=a3d149c3-c609-4708-b7eb-906472ebedbb", height: 300.0,),
                    SizedBox(height: 20.0,),
                    Text('CHUCKS', style: TextStyle( fontSize: 40.0, fontFamily: 'SairaB', color: Colors.white ),),
                    SizedBox(height: 30.0,),
                    Text('실시간게임에 참여하고', style: TextStyle( fontSize: 30.0, fontFamily: 'SairaR', color: Colors.white ),),
                    Text('상금의 주인공이 되세요', style: TextStyle( fontSize: 30.0, fontFamily: 'SairaR', color: Colors.white ),),
                  ],
                ),
              ),
              SmallCountDown()
            ],
          )

        ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 15), _goToNext);
  }

  _goToNext(Timer timer) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_)=>VictoryPage(gameRef: widget.gameRef)),
            (page){return page.isFirst;});
  }



}