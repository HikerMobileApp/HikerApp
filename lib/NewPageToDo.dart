import 'package:flutter/material.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Database.dart';

const Color myColor = Color(0xff243447);

class NewPageToDo extends StatefulWidget {
  NewPageToDoState createState() {
    return NewPageToDoState();
  }
}

class NewPageToDoState extends State<NewPageToDo> {
  //alert box
  final hikeName = TextEditingController();
  final hikeType = TextEditingController();
  final miles = TextEditingController();
  openAlertBox(String  title, String description, DocumentSnapshot doc, String mil) {
    return showDialog(
        context: context,
        
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: MediaQuery.of(context).size.width/1.1,
              height: MediaQuery.of(context).size.height/1.725,
              //height: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Edit Hike",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: title,
                        border: InputBorder.none,
                      ),
                      controller: hikeName,
                      maxLines: 6,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: description,
                        border: InputBorder.none,
                      ),
                      controller: hikeType,
                      maxLines: 6,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: mil,
                        border: InputBorder.none,
                      ),
                      controller: miles,
                      maxLines: 6,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        
                      ),
                      
                    ),
                    onTap: (){
                      if (hikeName.text != "" || hikeType.text != ""||miles.text != "") {
                        print("Done Clicked");
                        Database temp = new Database();
                        if(hikeName.text == ""){
                          hikeName.text =title;
                        }
                        if(hikeType.text == "" ){
                          hikeType.text =description;
                        }
                        if(miles.text == ""){
                          miles.text = mil;
                        }
                        temp.pushAddHike(hikeName.text, hikeType.text, miles.text);
                        hikeName.text = "";
                        hikeType.text = "";
                        miles.text = "";
                        Navigator.pop(context);
                      }
                      else if(hikeName.text == "" && hikeType.text == "" && miles.text == ""){
                        hikeName.text =title;
                        hikeType.text =description;
                        miles.text = mil;
                        print("Fields Left Empty");
                        Database temp = new Database();
                        temp.pushAddHike(hikeName.text, hikeType.text, miles.text);
                        hikeName.text = "";
                        hikeType.text = "";
                        miles.text = "";
                        Navigator.pop(context);
                      }
                      else{
                        print("idk what is happening");
                      }
                      Database temp = new Database();
                          temp.deleteHikeFromToDoPage(doc['Title']);
                    },
                    
                  ),
                ],
              ),
            ),
          );
        });
  }

 Future<void> _askedToLead() async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: const Text('Edit Hike'),
          children: <Widget>[
          SimpleDialogOption(
            onPressed: () {},
            child: const Text('Hike Name: '),
          ),
          SimpleDialogOption(
            onPressed: () {},
            child: const Text('Hike Description'),
          ),
        ],
      );
  
    }
  );
}
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
                            document['Title'], document['Type'], document['Miles'])),
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
                        Scaffold.of(context).showSnackBar(SnackBar( content: Text('Hike was moved to the done page')));
                        },
                    ),
                    new IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                      onTap: () {}    
                    ),
                  ],
                  secondaryActions: <Widget>[
                    new IconSlideAction(
                      caption: 'Edit',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                      onTap: () {openAlertBox(document['Title'],document['Type'], document, document['Miles']);},
                    ),
                    new IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                          Database temp = new Database();
                          temp.deleteHikeFromToDoPage(document['Title']);
                           Scaffold.of(context).showSnackBar(SnackBar( content: Text('Deleted')));
                        },
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
