import 'package:chucks/auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends InheritedWidget {
  final Auth auth;
  AuthProvider({Key key, Widget child, this.auth}) : super(key : key, child : child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static AuthProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AuthProvider) as AuthProvider);
  }

}