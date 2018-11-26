import 'package:flutter/material.dart';

class Notification{
  final String title;
  final String content;
  final DateTime createTime;

  Notification(this.title, this.content, this.createTime);
}


List<Notification> sampledata = [
    Notification("Welcome to Chucks", "Welcome to Chucks", DateTime(2018,11,16,13,15)),
    Notification("Special Event for Openning", "Very Very Sepcial Open event", DateTime(2018,11,16,14,22)),
    Notification("Update Report", "Our Application was Updated at this night", DateTime(2018,11,16,18,29)),
    Notification("Nofication for Event Resualt", "Congraturation This is birthday Ya!!", DateTime(2018,11,16,15,29)),
].toList();



class NotificationPage extends StatefulWidget {
  @override
  _NotiticationPageState createState() {
    return _NotiticationPageState();
  }

}

class _NotiticationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Notice", style: TextStyle(fontSize: 30.0, fontFamily: 'SairaM' ),),
            ListView(
              shrinkWrap: true,
              children: sampledata.map( (notice){
                return _buildNotificationTile(context, notice);
              } ).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context, Notification notice){
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.notifications_active, color: Colors.teal.withOpacity(0.6)),
          title: Text(notice.title, style: TextStyle( fontFamily: 'SairaR' , fontSize: 15.0 ),),
          subtitle: Text(notice.createTime.toIso8601String(), style: TextStyle(color: Colors.grey ,fontFamily: 'SairaL' , fontSize: 10.0 ) ,),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.teal.withOpacity(0.6),),
        ),
        Divider()
      ],
    );
  }

}