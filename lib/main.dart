import 'dart:async';
import 'package:chucks/auth.dart';
import 'package:chucks/login.dart';
import 'package:flutter/material.dart';
import 'package:chucks/current_history.dart';
import 'package:chucks/gameplay.dart';
import 'package:chucks/mypage.dart';
import 'package:chucks/notification.dart';
import 'package:chucks/rank.dart';
import 'package:chucks/victory.dart';
import 'package:chucks/auth_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          fontFamily: 'SairaR',
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder> {
          '/login' : (BuildContext context) => new LoginPage(),
        },
        home: new MyHomePage(title: 'Flutter Demo Home Page'),
        initialRoute: '/login',
        onGenerateRoute: _getRoute,

      ),
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }

}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;
  AuthStatus authStatus = AuthStatus.notDetermined;


  Timer _timer;
  DateTime _currentTime;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then( (user){
      setState(() {
        authStatus =
        user == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    } );
  }

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
                child: RaisedButton(
                  color: Colors.pinkAccent,
                  onPressed:  _currentTime.minute < 1 ? null : (){ Navigator.of(context).push( MaterialPageRoute(builder: (_)=>GamePlayPage()) ); },
                  child: _currentTime.minute < 1 ? Text('Waiting', style: TextStyle(
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
                ),
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
                                    image: new NetworkImage(
                                        'https://www.ienglishstatus.com/wp-content/uploads/2018/04/Anonymous-Whatsapp-profile-picture.jpg')
                                )
                            )),
                        SizedBox(width: 15.0,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("MyThumbs", style: TextStyle(fontFamily: 'SairaB', fontSize: 20.0),),
                              Text("Victory  3times", style: TextStyle(fontFamily: 'SairaM', fontSize: 15.0), ),
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
                ListTile(leading: Icon(Icons.help), title: Text('FAQ') ,onTap: (){},),
                ListTile(leading: Icon(Icons.settings), title: Text('Preperence') ,onTap: (){},),
              ],
            ),
          );
        }
    );
  }

}
