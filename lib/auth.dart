import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> currentUser();
  Future<FirebaseUser> firebaseCurrentUser();
  Future<String> signIn(String _email, String _password);
  Future<String> createUser(
      String _email, String _password, String _firstName, String _lastName);
  Future<void> signOut();
  Future<String> displayName();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String _email, String _password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email, password: _password);
    return user.uid;
  }

  Future<String> createUser(String _email, String _password, String _firstName,
      String _lastName) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<FirebaseUser> firebaseCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<String> displayName() async {
    FirebaseUser mCurrentUser = await FirebaseAuth.instance.currentUser();
    return mCurrentUser.displayName;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
