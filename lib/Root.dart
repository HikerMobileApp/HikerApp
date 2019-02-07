import 'package:flutter/material.dart';
import 'auth.dart';
import 'LoginPage.dart';
import 'Home.dart';
import 'Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth, this.themeData}) : super(key: key);
  final BaseAuth auth;
  final ThemeData themeData;
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  State<StatefulWidget> createState() =>  _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
  }

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        auth =  widget.auth;
        /*
        auth.displayName().then((result) {
          setState(() {
            globalUserName = result;
        });
      });
      */
        return LoginPage();
        break;
      case AuthStatus.signedIn:
        auth =  widget.auth;
        /*
        auth.displayName().then((result) {
          setState(() {
            globalUserName = result;
        });
      });
      */
        //onSignOut = () => _updateAuthStatus(AuthStatus.notSignedIn);
        onSignOut = () => null;
        return HomePage();
        break;
      default:
        return null;
    }
  }
}