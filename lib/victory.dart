import 'package:flutter/material.dart';
import 'package:chucks/rank.dart';

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
].toList();

class VictoryPage extends StatefulWidget {
  @override
  _VictoryPageState createState() {
    return _VictoryPageState();
  }
}

class _VictoryPageState extends State<VictoryPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ const Color(0x88330867), const Color(0xFF30cfd0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: Scaffold(
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
                        Text(2134.toString(), style: TextStyle(color: Colors.white, fontSize: 18.0),),
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
                  Text(10.toString(), style: TextStyle(color: Colors.amberAccent, fontSize: 20.0),)
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

              child: Center(child: Text("4K"+" \$", style: TextStyle( color: Colors.white, fontSize: 50.0, fontFamily: 'SairaB', fontStyle: FontStyle.italic ),)),
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

                        Text(400.toString() +"\$", style: TextStyle(color: Colors.amberAccent, fontSize: 20.0),),

                      ],
                    ),
                  ],
                )
            ),
            SizedBox(height: 60.0,),
            Container(
                width: double.infinity,
                height: 225.0,
                child: _buildWinnersListView(context))
          ],
        ),
      ),
    );
  }

  Widget _buildWinnersListView(BuildContext context){
    return ListView.builder(
        itemCount: sampledata.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => _buildWinnerListTile(context, sampledata[index]),
        shrinkWrap: true,
    );

  }

  Widget _buildWinnerListTile(BuildContext context, Userdata user){
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 30.0, 0.0),
      width: 120.0,
      height: 120.0,
      child: Column(
        children: <Widget>[
          _buildCircleImage(context, user.imgUrl),
          _buildNameText(context, user.name)
        ],
      ),
    );
  }
  
  Widget _buildCircleImage(BuildContext context, String url){
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.scaleDown)
      ),
    );
  }

  Widget _buildNameText(BuildContext context, String name){
    return Container(
      alignment: Alignment.center,
      height: 30.0,
      width: 50.0,
      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Text(name, style: TextStyle(color: Colors.white, fontFamily: 'SairaM'),),
    );
  }

}