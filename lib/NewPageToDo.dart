import 'package:flutter/material.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'Constants.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'Constants.dart';

class NewPageToDo extends StatefulWidget {
  NewPageToDoState createState() {
    return NewPageToDoState();
  }
}

class NewPageToDoState extends State<NewPageToDo> {
  static Card card1 = hikeCardMaker('Jade Lake', 'Backpacking', '20');
  static Card card2 = hikeCardMaker('Panarama Point', 'Day Hike', '5');
  static Card card3 = hikeCardMaker('Tuck and Robin Lake', 'Backpacking', '12');
  static Card card4 = hikeCardMaker('Poo Poo Point', 'Day Hike', '6');
  static Card card5 = hikeCardMaker('Matterhorn', 'Backpacking', '16');
  List<Widget> cards = [card1, card2, card3, card4, card5];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(globalUserName)
          .document("Hikes To Do")
          .collection("Hike List")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text("Loading");
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: hikeCardMaker(document['Title'], document['Type'], '1')
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
