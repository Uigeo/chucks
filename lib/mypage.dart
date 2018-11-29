import 'package:chucks/auth_provider.dart';
import 'package:chucks/myprize.dart';
import 'package:chucks/profile_edit.dart';
import 'package:flutter/material.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() {
    return _MyPageState();
  }

}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Row(
              children: <Widget>[
                Expanded(child: Column(
                  crossAxisAlignment : CrossAxisAlignment.start ,
                  children: <Widget>[
                    Text( AuthProvider.of(context).auth.user.displayName ?? 'NULL', style: TextStyle(fontFamily: 'SairaM', fontSize: 25.0 ),),
                    InkWell(
                        onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ProfileEditPage())); },
                        child: Text('Change Profile',
                          style: TextStyle(
                              fontFamily: 'SairaL',
                              decoration: TextDecoration.underline
                          ),))
                  ],
                  )
                ),
                Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                              AuthProvider.of(context).auth.user.imgUrl ??
                                'https://www.ienglishstatus.com/wp-content/uploads/2018/04/Anonymous-Whatsapp-profile-picture.jpg')
                        )
                    )),
              ],
            ),
            SizedBox(height: 100.0,),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey)) ),
                  child: InkWell(
                    onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MyPrizePage()));},
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text('My Prize', style: TextStyle(fontFamily: 'SairaL', fontSize: 18.0))),
                        Text('\$ '+ AuthProvider.of(context).auth.user.prize.toString(), style: TextStyle(fontFamily: 'SairaR', fontSize: 18.0 )),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey)) ),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Phone #', style: TextStyle(fontFamily: 'SairaL', fontSize: 18.0))),
                      Text( AuthProvider.of(context).auth.user.phone ?? "No Phone #" , style: TextStyle(fontFamily: 'SairaT', fontSize: 18.0 )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey)) ),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('E-Mail', style: TextStyle(fontFamily: 'SairaL', fontSize: 18.0))),
                      Text( AuthProvider.of(context).auth.user.email ?? 'Email' , style: TextStyle(fontFamily: 'SairaT', fontSize: 18.0 )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey)) ),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text('Recommand Code', style: TextStyle(fontFamily: 'SairaL', fontSize: 18.0))),
                      Text( AuthProvider.of(context).auth.user.uid.substring(20) ?? "NULL", style: TextStyle(fontFamily: 'SairaT', fontSize: 18.0 )),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}