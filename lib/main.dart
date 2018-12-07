import 'package:flutter/material.dart'; 
import 'LoginPage.dart';

const Color dark_green = Color(0xff141d26);
const Color light_dark = Color(0xff243447);

void main() => runApp( new MaterialApp(
  theme: new ThemeData(
    accentColor: Colors.greenAccent,
    hintColor: Colors.greenAccent,
    canvasColor: light_dark,
  ),
  home: new LoginPage(),
  
));

