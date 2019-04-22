import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Database.dart';
import 'StatCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HikerPage extends StatefulWidget {
  final String name;
  final String profPic;
  final String miles;
  HikerPage({Key key, @required this.name, this.profPic, this.miles});
  _HikerPage createState() =>
      new _HikerPage(username: name, profilePic: profPic, milesHiked: miles);
}

printName(String name) {
  print(name);
  return;
}

Container button;
int doneHikes;
int todoHikes;
double milesHiked;
double totMiles = 0.0;
Color followColor = Color(0xff75aaff);
Color lightDark = Color(0xff243447);
List<DocumentSnapshot> doneHikesReturn;
Database temp = new Database();
String icon;

Container hikecardToDo(
    String hikeName, String hikeType, String miles, var context) {
  if (hikeType == "Multi-Night") {
    icon = "weatherNight";
  } else if (hikeType == "Day Hike") {
    icon = "walk";
  } else if (hikeType == "Backpacking") {
    icon = "tent";
  } else {
    icon = "pineTree";
  }
  return Container(
    width: context.size.width / 2,
    //padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(color: lightDark),
    child: new Card(
      child: new ListTile(
        leading: Icon(MdiIcons.fromString(icon)),
        title: AutoSizeText(
              hikeName,
              style: TextStyle(fontSize: 16.0),
              maxLines: 2,
            ),
        subtitle: (Text(miles + ' mile \n' + hikeType)),
        isThreeLine: true,
      ),
    ),
  );
}

class _HikerPage extends State<HikerPage> {
  bool pressAttention = false;
  List<String> following;
  final String username;
  final String profilePic;
  final String milesHiked;
  _HikerPage(
      {Key key, @required this.username, this.profilePic, this.milesHiked});

  void _getFollowing() {
    var userQuery = Firestore.instance.collection(globalUserName);
    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        setState(() {
          following = List.from(data.documents[0].data['Following']);
        });
      }
    });
  }

  Container followButton(String username) {
    return new Container(
        margin: EdgeInsets.only(top: 30.0),
        width: 250.0,
        height: 50.0,
        child: RaisedButton(
            child: pressAttention
                ? Text(
                    "Unfollow",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700),
                  )
                : Text(
                    "Follow",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700),
                  ),
            elevation: 6.0,
            color: pressAttention ? Colors.red : Colors.blue,
            onPressed: () {
              setState(() => pressAttention = !pressAttention);
              pressAttention
                  ? temp.addFollower(username)
                  : temp.unFollow(username);
            }));
  }

  Container unfollowButton(String username) {
    return new Container(
        margin: EdgeInsets.only(top: 30.0),
        width: 250.0,
        height: 50.0,
        child: RaisedButton(
            child: pressAttention
                ? Text(
                    "Follow",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700),
                  )
                : Text(
                    "Unfollow",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700),
                  ),
            elevation: 6.0,
            color: pressAttention ? Colors.blue : Colors.red,
            onPressed: () {
              setState(() => pressAttention = !pressAttention);
              pressAttention
                  ? temp.unFollow(username)
                  : temp.addFollower(username);
            }));
  }

  Container _button(List<String> following, String username) {
    print(following.toString());
    if (following == null || globalUserName == username) {
      return Container(
        child: SizedBox(
          height: 20,
        ),
      );
    } else if (!following.contains(username)) {
      return followButton(username);
    } else {
      return unfollowButton(username);
    }
  }

  @override
  void initState() {
    super.initState();
    _getFollowing();
    _button(following, username);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: lightDark,
          title: new Text(username),
          actions: <Widget>[],
        ),
        body: new Stack(children: <Widget>[
          ClipPath(
            child: Container(color: Colors.black.withOpacity(0.8)),
            clipper: GetClipper(),
          ),
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height / 30,
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
                  //SizedBox(height: 5.0),
                  _button(following, username),
                  SizedBox(height: 15.0),
                  Text(
                    'Stats: ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontFamily: 'Montserrat'),
                  ),
                  SizedBox(height: 25.0),
                  Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child:
                            statCardMaker("Miles Hiked", milesHiked.toString()),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                          child: new Text(
                            "Hikes to-do",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                          height: 25.0),
                      Container(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection(username)
                                  .document("Hikes To Do")
                                  .collection("Hike List")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                      child: Center(child: Text("No Hikes")));
                                }
                                return Container(
                                    height:
                                        MediaQuery.of(context).size.width / 4,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        //padding: EdgeInsets.all(8.0),
                                        reverse: false,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            snapshot.data.documents.length,
                                        itemBuilder: (_, int index) {
                                          String hikeName = snapshot
                                              .data.documents[index]["Title"];
                                          String hikeType = snapshot
                                              .data.documents[index]["Type"];
                                          String miles = snapshot
                                              .data.documents[index]["Miles"];
                                          return new GestureDetector(
                                            onTap: () {},
                                            child: hikecardToDo(hikeName,
                                                hikeType, miles, mediaQuery),
                                          );
                                        }));
                              })),
                      SizedBox(height: 10),
                      SizedBox(
                          child: new Text(
                            "Done Hikes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                          height: 25.0),
                      Container(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection(username)
                                  .document("Done Hikes")
                                  .collection("Hike List")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                      child: Center(child: Text("No Hikes")));
                                }
                                return Container(
                                    height:
                                        MediaQuery.of(context).size.width / 4,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        //padding: EdgeInsets.all(8.0),
                                        reverse: false,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            snapshot.data.documents.length,
                                        itemBuilder: (_, int index) {
                                          String hikeName = snapshot
                                              .data.documents[index]["Title"];
                                          String hikeType = snapshot
                                              .data.documents[index]["Type"];
                                          String miles = snapshot
                                              .data.documents[index]["Miles"];
                                          return new GestureDetector(
                                            onTap: () {},
                                            child: hikecardToDo(hikeName,
                                                hikeType, miles, mediaQuery),
                                          );
                                        }));
                              })),
                    ],
                  )
                ],
              ))
        ]));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
