import 'package:flutter/material.dart';
//import 'main.dart';
//import 'package:flutter/material.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'Constants.dart';
//import 'package:firebase_auth/firebase_auth.dart';

import 'Constants.dart';

class NewPageDone extends StatefulWidget {
    NewPageDoneState createState() {
      return NewPageDoneState();
  }
}
 
  class NewPageDoneState extends State<NewPageDone> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(globalUserName)
          .document("Done Hikes")
          .collection("Hike List")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            );
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: doneHikeCardMaker(document['Title'], document['Type'], '1')
                  //title: new Text(document['Title']),
                  //subtitle: new Text(document['Type']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
