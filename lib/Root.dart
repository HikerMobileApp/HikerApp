import 'package:flutter/material.dart';
import 'auth.dart';
import 'LoginPage.dart';
import 'Home.dart';
import 'Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'SharedPreferences.dart';

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
    _loadUsername();
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

      _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      globalUserName = (prefs.getString('username') ?? "username");
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
           sp.setUsername(result);
        });
      });
      */
      
/*
      auth.firebaseCurrentUser().then((result) {
          setState(() {
            globalUser = result;
        });
      });
      */
      
        return LoginPage();
        break;
      case AuthStatus.signedIn:
        auth =  widget.auth;
        //_loadUsername();

        /*
       sp.getUsername().then((name){
         setState(() {
           globalUserName = name;
         });
       });
       */
        
        /*
        auth.displayName().then((result) {
          setState(() {
            globalUserName = result;
        });
      });
      */

/*
      auth.firebaseCurrentUser().then((result) {
          setState(() {
            globalUser = result;
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