import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Database.dart';
import 'main.dart';

class NearMe extends StatefulWidget {
  @override
  _NearMe createState() => new _NearMe();
}

int doneHikes;
int todoHikes;
double milesHiked;
double totMiles = 0.0;
List<DocumentSnapshot> doneHikesReturn;
Database temp = new Database();

class _NearMe extends State<NearMe> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
              backgroundColor: light_dark,
              title: new Text("Near You"),
              actions: <Widget>[
              ],
        ),
        //body: ,
      
    );


  }

}