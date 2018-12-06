import 'package:chucks/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userdata {
  final String name;
  final int prize;
  final String imgUrl;
  Userdata(this.name, this.prize, this.imgUrl);
}

List<Userdata> sampledata = [
  Userdata('Diva', 21423,'https://img00.deviantart.net/893a/i/2017/146/b/a/overwatch_reaper_spray_vector_by_kyuubi3000-dbah5zq.png' ),
  Userdata('Para', 20000,'http://i.imgur.com/BYMlFFd.png' ),
  Userdata('MAI', 16323,'https://static.tumblr.com/80d864764c458d042a285049047d0bd3/fhxy404/UUDp9wznz/tumblr_static_6oyo9gsn05c0wc8gcg84gscso.png' ),
  Userdata('Coco', 12424,'https://img00.deviantart.net/03e3/i/2016/172/a/6/overwatch_junkrat_spray_vector_by_kyuubi3000-da737om.png' ),
  Userdata('Bongu', 11111,'https://pre00.deviantart.net/8209/th/pre/f/2016/180/a/f/overwatch_zernyatta_spray_vector_by_kyuubi3000-da833if.png' ),
  Userdata('Winston', 9423,'http://i.imgur.com/BYMlFFd.png' ),
  Userdata('Mercy', 9223,'https://img00.deviantart.net/893a/i/2017/146/b/a/overwatch_reaper_spray_vector_by_kyuubi3000-dbah5zq.png' ),
  Userdata('Reaper', 8223,'https://vignette.wikia.nocookie.net/villains/images/d/d2/Overwatch_sombra_skull_spray.png/revision/latest?cb=20180724220359' ),
  Userdata('Genji',7000, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKRbTzq1ptq5scW_1zAa0tmZjZpu-VDByv5O0TuTQXMGUf3r82yA'),
  Userdata('Meico', 6700, 'https://ubisafe.org/images/junkrat-transparent-mei-sprays.png'),
  Userdata('Hanjo', 4700, 'https://techflourish.com/images/overwatch-hanzo-clipart-1.jpg'),
  Userdata('LoadHog', 4500,'https://i.stack.imgur.com/E6cN6.png'),
  Userdata('Anna', 4222, 'https://res.cloudinary.com/teepublic/image/private/s--bJC7BOsJ--/t_Preview/b_rgb:ffffff,c_limit,f_jpg,h_630,q_90,w_630/v1515401290/production/designs/2263129_1.jpg'),
  Userdata('BlackWidow', 3232, 'https://img00.deviantart.net/0fc8/i/2016/171/7/1/overwatch___widowmaker_spray_by_al_proto-da6va1m.png'),
  Userdata('Widowmaker', 2333, "https://pre00.deviantart.net/a08a/th/pre/i/2016/198/0/c/overwatch_widowmaker_spray_vector_by_kyuubi3000-daabwqy.png"),
  Userdata('Zarya', 2222, 'https://pre00.deviantart.net/fc2f/th/pre/i/2016/228/a/b/overwatch_zarya_spray_vector_by_kyuubi3000-dae5afl.png')

].toList();

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() {
      return _RankPageState();
  }

}

class _RankPageState extends State<RankPage> {

  int i =1;
  int j =4;

  @override
  Widget build(BuildContext context) {

      return FutureBuilder<List<GameUser>>(
          future: Firestore.instance.collection('users').orderBy('totalPrize', descending: true ).getDocuments().then(
                  (query){ return query.documents.map( (snapshot){return GameUser.fromSnapshot(snapshot);} ).toList(); } ) ,
          builder: (BuildContext context, AsyncSnapshot<List<GameUser>> snapshot){
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ const Color(0xFFf5576c), const Color(0x88f093fb)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
              ),
              child: Scaffold(
                backgroundColor: Color(0x00000000),
                appBar: AppBar(
                  title: Text("RANK", style: TextStyle(fontFamily: 'SairaB'),),
                  centerTitle: true,
                  backgroundColor: Color(0x00FFFFFF),
                  elevation: 0.0,
                  leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: (){ Navigator.pop(context); }),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: <Widget>[
                    SizedBox(height: 60.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (snapshot.data == null) ? [_buildWaiting()] : snapshot.data.sublist(0,3).map( (d){
                        if(i%3 == 1) i =1;
                        return _highRank(context, d.imgUrl, d.displayName, d.totalPrize, i++);} ).toList(),
                    ),
                    SizedBox(height: 60.0,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: _headerbar(),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xFFe7e7e7)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ListView(
                              shrinkWrap: true,
                              children: (snapshot.data == null) ? [_buildWaiting()] : snapshot.data.sublist(3).map((d){
                                if(j > snapshot.data.length) j =4;
                                return _rankTile(d.imgUrl, d.displayName, d.prize, j++);
                              }).toList()
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
      );
  }

  Widget _headerbar (){
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      color: Colors.white,
      child: ListTile(
        leading: Row(
          children: <Widget>[
            Text('#', style: TextStyle(color: Colors.grey, fontFamily: 'SairaR', fontSize: 15.0),),
            SizedBox(width: 20.0,),
            Text('Prifile', style: TextStyle(color: Colors.grey, fontFamily: 'SairaR', fontSize: 15.0),),
            SizedBox(width: 20.0,),
            Text('name', style: TextStyle(color: Colors.black, fontFamily: 'SairaR', fontSize: 15.0 ),),
          ],
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('Prize',style: TextStyle(color: Colors.black, fontFamily: 'SairaR', fontSize: 15.0),  ),
            SizedBox(width: 10.0,),
            Icon(Icons.monetization_on)
          ],
        ),
      ),
    );
  }

  Widget _rankTile( imgUrl, String name, int prize, int grade){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: ListTile(
        leading: Row(
          children: <Widget>[
            Text(grade.toString(), style: TextStyle(color: Colors.grey, fontFamily: 'SairaR', fontSize: 15.0),),
            SizedBox(width: 20.0,),
            Container(
              height: 40.0,
              width :  40.0,
              decoration: BoxDecoration( color: Colors.white, shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: NetworkImage( imgUrl ?? "" )) ) ,
            ),
            SizedBox(width: 20.0,),
            Text(name, style: TextStyle(color: Colors.black, fontFamily: 'SairaR', fontSize: 15.0 ),),
          ],
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(prize.toString(),style: TextStyle(color: Colors.black, fontFamily: 'SairaR', fontSize: 15.0),  ),
            SizedBox(width: 10.0,),
            Icon(Icons.monetization_on)
          ],
        ),
      ),
    );
  }
  
  Widget _highRank(BuildContext context, String imgUrl, String name, int prize, int grade ){
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration( color: Colors.black26, shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(imgUrl ?? "")) ) ,
              ),
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration( shape: BoxShape.circle, color: Colors.amber ),
                child: Center(child: Text(grade.toString(), style: TextStyle( color: Colors.white, fontFamily: 'SairaM', fontSize: 20.0),  )),
              ),
            ],
          ),
          Container(
            child: Text(name, style: TextStyle( color: Colors.white, fontFamily: 'SairaB', fontSize: 15.0), ),
          ),
          Container(
            decoration: BoxDecoration( color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.all(Radius.circular(13.0)) ) ,
            child: SizedBox(width: 70.0,
                child: Center(
                  child: Text(
                    prize.toString(), 
                    style: TextStyle( color: Colors.white, fontFamily: 'SairaR'),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaiting() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

}

