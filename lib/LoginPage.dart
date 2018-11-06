import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType{
  login,
  register
}


class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

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
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print('Signed in: ${user.uid}');
      }
      catch(e){
        print(e);
      }
    }
  }

  void moveToRegister(){
    setState(() {
      _formType = FormType.register;
        });
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
    final email = TextFormField(
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
        child: MaterialButton(
          elevation: 20.0,
          minWidth: 200.0,
          height: 42.0,
          onPressed: validateAndSubmit,
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
    );

    final registerLabel = FlatButton(
      child: Text(
        'Register New User?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: moveToRegister,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registerLabel
          ],
        ),
        ),
      ),
    );
  }
}