import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RegisterPage.dart';
import 'Home.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const Color light_dark = Color(0xff243447);
const Color dark_green = Color(0xff141d26);
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

bool isLoggedIn = false;
var profile;

String returnProfilePic(){
  if(profile != null){
  print(profile['picture']['data']['url']);
  return profile['picture']['data']['url'];
  }
  else {
    return "";
  }
}
class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  bool validateAndSave(){
    final form = formKey.currentState;
    form.save();
    if (form.validate()){
      print('Form is valid. Email: $_email Password: $_password');
      return true;
    }
    else{
      print('Form is not valid. Email: $_email Password: $_password');
      return false;
    }
  }
void onLoginStatusChanged(bool LoggedIn, {profileData}) {
    setState(() {
      isLoggedIn = LoggedIn;
      profile = profileData;
    });
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.nativeOnly;
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
     switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        FirebaseAuth.instance.signInWithFacebook(accessToken: facebookLoginResult.accessToken.token);
        onLoginStatusChanged(true);
        break;
    }
    if(isLoggedIn){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult
                .accessToken.token}');

        profile = json.decode(graphResponse.body);
        print(profile.toString());
    }
  }

  void validateAndSubmit() async{
    if(validateAndSave()){
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print('Verified? : ${user.isEmailVerified}');
        if(user.isEmailVerified){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
        }
      }
      catch(e){
        print(e);
      }
    }
  }

  void moveToRegister(){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
  }

  @override
  Widget build(BuildContext context) {

    final title = 
    Text(
    'Summit Log',
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white),
);

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
    
    final email = TextFormField(
      style: TextStyle(fontSize: 20.0, color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty': null,
      onSaved: (value) => _email = value,
    );

    final password = TextFormField(
      style: TextStyle(fontSize: 20.0, color: Colors.white),
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      validator: (value) => value.isEmpty ? 'Password can\'t be empty': null,
      onSaved: (value) => _password = value,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          onPressed: validateAndSubmit,
          color: Colors.green,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
    );

    final loginFacebookButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          onPressed: initiateFacebookLogin,
          color: Colors.blue,
          child: Text('Facebook', style: TextStyle(color: Colors.white)),
        ),
    );

    final registerLabel = FlatButton(
      child: Text(
        'Register New User?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: moveToRegister,
    );

    return Scaffold(
      backgroundColor: light_dark,
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            title,
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            loginFacebookButton,
            registerLabel
          ],
        ),
        ),
      ),
    );
  }
}