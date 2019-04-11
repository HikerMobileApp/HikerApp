import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

const Color light_dark = Color(0xff243447);
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => new _RegisterPage();
}


class _RegisterPage extends State<RegisterPage> {
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

  void validateAndSubmit() async{
    if(validateAndSave()){
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        user.sendEmailVerification();
        print('Registered user: ${user.uid}');
        Navigator.pop(context);
      }
      catch(e){
        print(e);
      }
    }
  }

  void moveToLogin(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final title = 
    Text(
    'Summit Log',
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, color: Colors.white),
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
          child: Text('Register', style: TextStyle(color: Colors.white)),
        ),
    );

    final alreadyHaveAccountLabel = FlatButton(
      child: Text(
        'Already Have an Account?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: moveToLogin,
    );

    return Scaffold(
      backgroundColor: light_dark,
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
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
            alreadyHaveAccountLabel
          ],
        ),
        ),
      ),
    );
  }
}