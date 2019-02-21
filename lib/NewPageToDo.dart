import 'package:flutter/material.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Database.dart';

class NewPageToDo extends StatefulWidget {
  NewPageToDoState createState() {
    return NewPageToDoState();
  }
}

class NewPageToDoState extends State<NewPageToDo> {

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
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            );
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Slidable(
                  delegate: new SlidableDrawerDelegate(),
                  actionExtentRatio: 0.25,
                  child: new Container(
                    color: Colors.transparent,
                    child: new ListTile(
                        title: doneHikeCardMaker(
                            document['Title'], document['Type'], '1')),
                  ),
                  actions: <Widget>[
                    new IconSlideAction(
                      caption: 'Done',
                      color: Colors.blue,
                      icon: Icons.check,
                      onTap: ()  { 
                        Database temp = new Database();
                        temp.pushAddDoneHike(document['Title'], document['Type']);
                        temp.deleteHikeFromToDoPage(document['Title']);
                        } /*_showSnackBar('Archive')*/,
                    ),
                    new IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                      onTap: () => {} /*_showSnackBar('Share')*/,
                    ),
                  ],
                  secondaryActions: <Widget>[
                    new IconSlideAction(
                      caption: 'More',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                      onTap: () => {} /*_showSnackBar('More')*/,
                    ),
                    new IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                          Database temp = new Database();
                          temp.deleteHikeFromToDoPage(document['Title']);
                        } /*_showSnackBar('Delete')*/,
                    ),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }
}
