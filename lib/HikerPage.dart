import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';
import 'Database.dart';
import 'StatCard.dart';
import 'main.dart';

class HikerPage extends StatefulWidget {
  final String name;
  final String profPic;
  final String miles;
   HikerPage({Key key, @required this.name, this.profPic, this.miles});
  _HikerPage createState() => new _HikerPage(username: name, profilePic: profPic, milesHiked: miles);
}



int doneHikes;
int todoHikes;
double milesHiked;
double totMiles = 0.0;
List<DocumentSnapshot> doneHikesReturn;
Database temp = new Database();

class _HikerPage extends State<HikerPage> {
final String username;
final String profilePic;
final String milesHiked;
 _HikerPage({Key key, @required this.username, this.profilePic, this.milesHiked});

  @override
  void initState() {
    super.initState();
  }


@override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
              backgroundColor: light_dark,
              title: new Text(username),
              actions: <Widget>[
              ],
        ),
        body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.black.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        //Center(
        Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height / 10,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: new NetworkImage(profilePic),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 1.0),
                Text(
                  username,
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Stats: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 25.0),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  
                child: 
                Column(
                  children: <Widget>[
                      statCardMaker("Miles Hiked", milesHiked.toString()),
                  ]
                )
                )
              ],
            ))
      ],
    ));
  }
}



class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
  