import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Database.dart';
import 'HikerPage.dart';

class Hikers extends StatefulWidget {
  @override
  _Hikers createState() => new _Hikers();
}

  Database temp = new Database();
Card profileCard(String name, var miles, String profPic){
  if(miles == null){
     miles = 0;
  }
  if(profPic == ""){
    profPic = "https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg";
  }
  return new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(profPic)),
            title:  Text(name),
            subtitle: new Text("Miles Hiked: " + miles.toString()),
            //subtitle:  Text(miles + ' mile ' + hikeType),
            ),
          ]
        )
      );
}

class _Hikers extends State<Hikers>{

            @override
            void initState() {
              super.initState();
            }

Widget build(BuildContext context) {
  Color lightDark = Color(0xff243447);
          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: lightDark,
              title: new Text("Hikers"),
              actions: <Widget>[
              ],
            ),
              body: new Column(
              children: <Widget>[
                new Flexible(
                  child: StreamBuilder(
                    stream: Firestore.instance.collection("USERS").snapshots(),
                    builder: (context, snapshot){
                      if (!snapshot.hasData){
                        return Container(
                          child: Center(
                            child: Text("No data")
                          )
                        );
                      }

                    return ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: false,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, int index) {
                        String user = snapshot.data.documents[index]["Name"];
                        var miles = snapshot.data.documents[index]["MilesHiked"];
                        String profPic = snapshot.data.documents[index]["profilePic"];
                        return 
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HikerPage(name: user, profPic: profPic, miles: miles.toString(),)),
                              );
                            },
                            child:
                           profileCard(user, miles, profPic),
                          );
                      }
                    );        
                  }
                )

                  ),
                ]
                        )
                        );
              }
              }