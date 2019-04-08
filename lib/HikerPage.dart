import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Database.dart';
import 'StatCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


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
Color lightDark = Color(0xff243447);
List<DocumentSnapshot> doneHikesReturn;
Database temp = new Database();
String icon;

Container hikecardToDo(String hikeName, String hikeType, String miles, var context){
  if(hikeType == "Multi-Night"){
      icon = "weatherNight";
  }
  else if(hikeType == "Day Hike"){
      icon = "walk";
  }
  else if(hikeType == "Backpacking"){
      icon = "tent";
  }
  else{
      icon = "pineTree";
  }
  return 
      Container(
        //color: Colors.white,
        width: context.size.width/2,
        decoration: BoxDecoration(border: Border.all(
            color: lightDark,
            width: 8.0,
          ),
          color: Colors.white
          ),
        //height: 20,
        //width: 20,
        child: new ListTile(
            leading: Icon(MdiIcons.fromString(icon)),
            title:  Text(hikeName),
            subtitle:  Text(miles + ' mile ' + hikeType),
            ),
      );
}

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
  var mediaQuery = MediaQuery.of(context);
    return new Scaffold(
        appBar: new AppBar(
              backgroundColor: lightDark,
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
                
                  
              Column(
                  children: <Widget>[
                    Container(
                  width: MediaQuery.of(context).size.width/2,
                  child:
                      statCardMaker("Miles Hiked", milesHiked.toString()),
                    ),
                     Container(
                        
                        child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                          .collection(username)
                          .document("Hikes To Do")
                          .collection("Hike List")
                          .snapshots(),

                        builder: (context, snapshot){
                      if (!snapshot.hasData){
                        return Container(
                          child: Center(
                            child: Text("No Hikes")
                          )
                        );
                      }
                        return Container(
                          height: MediaQuery.of(context).size.width/5,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                      padding: EdgeInsets.all(1.0),
                      reverse: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, int index) {
                        String hikeName = snapshot.data.documents[index]["Title"];
                        String hikeType = snapshot.data.documents[index]["Type"];
                        String miles = snapshot.data.documents[index]["Miles"];
                        return 
                          new GestureDetector(
                            onTap: () {
                            },
                            child:
                              hikecardToDo(hikeName, hikeType, miles, mediaQuery),
                              );
                          
                      }
                    ) 
                        );    
                  }

            
                
                )
                      ) 
              ],
            )
      ],
    ))
      ]
        )
    );
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
  