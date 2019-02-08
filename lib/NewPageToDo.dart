import 'package:flutter/material.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'Constants.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'Database.dart';
import 'dart:async';

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
    Database temp = new Database();
    var name = temp.getUserName();
    print("IN NEW PAGE");
    print(name.toString());
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          //.collection(auth.currentUser().toString())
          //.collection("robinkumar123")
          .collection(name.toString())
          //.collection("Isaiah Scheel")
          .document("Hikes To Do")
          .collection("Hike List")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new CircularProgressIndicator(),
          //new Text("Loading"),
        ],
      );
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
  /*@override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
                child: new ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];

                      return Dismissible(
                        key: ObjectKey(card),
                        // We also need to provide a function that tells our app
                        // what to do after an item has been swiped away.
                        onDismissed: (DismissDirection direction) {
                          // Remove the item from our data source.
                          if (direction == DismissDirection.endToStart) {
                            setState(() {
                              cards.removeAt(index);
                            });
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("$card dismissed")));
                          }
                        },
                        background: Container(color: Colors.red),
                        child: ListTile(title: card),
                      );
                    }))
                    );
  }*/
}
