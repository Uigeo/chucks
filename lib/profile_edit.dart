import 'dart:async';
import 'dart:io';

import 'package:chucks/auth_provider.dart';
import 'package:chucks/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ProfileEditPage extends StatefulWidget {
  final GameUser user;
  ProfileEditPage({Key key, this.user}) : super( key : key );

  @override
  _ProFileEditPageState createState() {
    return _ProFileEditPageState(user: user,
        nameControl: TextEditingController(text:user.displayName),
        phoneControl: TextEditingController( text:user.phone)
    );
  }

}

class _ProFileEditPageState extends State<ProfileEditPage> {
  final GameUser user;
  TextEditingController nameControl;
  TextEditingController phoneControl;
  _ProFileEditPageState({Key key, this.user, this.nameControl, this.phoneControl});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();




  Future<File> _imageFile;

  @override
  Widget build(BuildContext context) {

    return _buildBody(context, widget.user);
  }

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
        _imageFile = ImagePicker.pickImage(source: source);
    });
  }



  Widget _previewImage(String imgUrl) {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return _circleImage(snapshot.data);
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return _circleNetworkImage( imgUrl ??
            'https://www.ienglishstatus.com/wp-content/uploads/2018/04/Anonymous-Whatsapp-profile-picture.jpg');
          }
        });
  }

  Widget _circleImage(File file) {
    return Stack(
      children: <Widget>[
        Container(
          height: 140.0,
          width: 140.0,
          decoration: BoxDecoration( color: Colors.black26, shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: FileImage(file)) ) ,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(100.0, 100.0, 0.0, 0.0),
          child: InkWell(
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration( shape: BoxShape.circle, color: Colors.white ),
              child: Center(child: Icon(Icons.camera, size: 30.0,)  )
            ),
            onTap: (){_onImageButtonPressed(ImageSource.gallery);},
          ),
        ),
      ],
    );
  }

  Widget _circleNetworkImage(String imgUrl) {
    return Stack(
      children: <Widget>[
        Container(
          height: 140.0,
          width: 140.0,
          decoration: BoxDecoration( color: Colors.black26, shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(imgUrl))) ,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(100.0, 100.0, 0.0, 0.0),
          child: InkWell(
            child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration( shape: BoxShape.circle, color: Colors.white ),
                child: Center(child: Icon(Icons.camera, size: 30.0,)  )
            ),
            onTap: (){_onImageButtonPressed(ImageSource.gallery);},
          ),
        ),
      ],
    );
  }


  Widget _buildBody(BuildContext context, GameUser user){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      key: scaffoldKey,
      body: Container(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Profile', style: TextStyle(fontSize: 30.0, fontFamily: 'SairaM' ),  ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _previewImage(user.imgUrl),
              ],
            ),
            SizedBox(height: 30.0,),
            Text('Display Name', style: TextStyle(fontSize: 20.0, fontFamily: 'SairaM' ),  ),
            TextFormField(
              controller: this.nameControl,
            ),
            SizedBox(height: 50.0,),
            Text('Phone #', style: TextStyle(fontSize: 20.0, fontFamily: 'SairaM' ),  ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
              child:  TextFormField(
                controller:  this.phoneControl,
              ),
            ),

            SizedBox(height: 20.0,),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: _save,
                    child: Text('Save', style: TextStyle(fontFamily: 'SairaM', fontSize: 20.0, color: Colors.white),),
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _save(){
    user.ref.updateData({
      'phone' : phoneControl.text,
      'displayName' : nameControl.text
    });
  }

}

