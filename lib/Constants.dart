import 'auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String img;
BaseAuth auth;
FirebaseUser globalUser;
String globalUserName;
VoidCallback onSignOut;