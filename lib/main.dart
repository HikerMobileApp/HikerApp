import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'NewPageDone.dart';
//import 'NewPageToDo.dart';
//import 'HikeCard.dart';
//import 'AddHikePage.dart';
import 'LoginPage.dart';

const Color dark_green = Color(0xff141d26);
const Color light_dark = Color(0xff243447);

void main() => runApp( new MaterialApp(
  theme: new ThemeData(
    accentColor: Colors.teal,
    hintColor: Colors.teal,
    canvasColor: light_dark,
  ),
  home: new LoginPage(),
  
));

