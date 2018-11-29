import 'package:chucks/auth.dart';
import 'package:chucks/home.dart';
import 'package:chucks/login.dart';
import 'package:flutter/material.dart';
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

          fontFamily: 'SairaR',
          primarySwatch: Colors.blue,
        ),

        home: new MyHomePage(title: 'Flutter Demo Home Page'),

      ),
    );
  }

//  Route<dynamic> _getRoute(RouteSettings settings) {
//    if (settings.name != '/login') {
//      return null;
//    }
//
//    return MaterialPageRoute<void>(
//      settings: settings,
//      builder: (BuildContext context) => LoginPage(),
//      fullscreenDialog: true,
//    );
//  }

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

  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then( (user){
      setState(() {
        print("Do it");
        authStatus =
        user == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    } );
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }



  @override
  Widget build(BuildContext context) {
    print(authStatus);
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginPage( onSignedIn: _signedIn);
      case AuthStatus.signedIn:
        return HomePage( onSignedOut : _signedOut );
    }
    return null;
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
