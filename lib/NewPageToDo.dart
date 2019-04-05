import 'package:flutter/material.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Database.dart';
import 'package:share/share.dart';

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
  final longitude = TextEditingController();
  final latitude = TextEditingController();
  final tripDescription = TextEditingController();
  final dateCompleted = TextEditingController();
  openAlertBox(String  title, String description, DocumentSnapshot doc, String mil) {
    return showDialog(
        context: context,

        builder: (BuildContext context) {
          var mediaQuery =MediaQuery.of(context);
          return AlertDialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))
            ),
            contentPadding: mediaQuery.padding,
            content: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: mediaQuery.padding,
              width: MediaQuery.of(context).size.width/1.1,
              height: MediaQuery.of(context).size.height/3.465,
              //alignment: Alignment(0.0, MediaQuery.of(context).size.height),
              //height: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Edit Hike",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: title,
                        border: InputBorder.none,
                      ),
                      controller: hikeName,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: description,
                        border: InputBorder.none,
                      ),
                      controller: hikeType,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: mil,
                        border: InputBorder.none,
                      ),
                      controller: miles,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  InkWell(
                    
                    child: Container(
                      alignment:Alignment(0.0, 0.0),
                      height: MediaQuery.of(context).size.height/15.1,
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
                      print("Description = " + description);
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
                        temp.deleteHikeFromToDoPage(doc['Title']);
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
            
                    },
                    
                  ),
                  
                ],
              ),
            ),
          );
        });
  }

  openAlertBoxForDone(String  title, String description, DocumentSnapshot doc, String mil) {
    /*DateTime _date = new DateTime.now();
    //TimeOfDay _time = new TimeOfDay.now();
    print("Description = " + description);
    Future<Null> _selectData(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now()
      );

      if(picked != null && picked != _date) {
        setState(() {
          _date =picked;
        });
      }
    }*/
    return showDialog(
        context: context,

        builder: (BuildContext context) {
          var mediaQuery =MediaQuery.of(context);
          return AlertDialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))
            ),
            contentPadding: mediaQuery.padding,
            content: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: mediaQuery.padding,
              width: MediaQuery.of(context).size.width/1.1,
              height: MediaQuery.of(context).size.height/3.465,
              //height: MediaQuery.of(context).size.height,
              //alignment: Alignment(0.0, MediaQuery.of(context).size.height),
              //height: 500.0,
              child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Complete Trip Report",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: title,
                        border: InputBorder.none,
                      ),
                      controller: hikeName,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: description,
                        border: InputBorder.none,
                      ),
                      controller: hikeType,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: mil,
                        border: InputBorder.none,
                      ),
                      controller: miles,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter longitude",
                        border: InputBorder.none,
                      ),
                      controller: longitude,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter latitude",
                        border: InputBorder.none,
                      ),
                      controller: latitude,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "Describe your hike",
                        border: InputBorder.none,
                      ),
                      controller: tripDescription,
                      maxLines: 2,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    /*child: new Column(
                      children: <Widget>[
                        new Text('Date completed: ${_date.day} ${_date.month} ${_date.year}'),
                        new RaisedButton(
                          child: new Text('Select Date'),
                          onPressed: (){_selectData(context);  print(_date.toString());},
                        ),
                      ],
                    ),*/
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Date completed",
                        border: InputBorder.none,
                      ),
                      controller: dateCompleted,
                      maxLines: 1,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: mediaQuery.size.height/400,
                  ),

                  InkWell(
                    child: Container(
                      alignment:Alignment(0.0, 0.0),
                      height: MediaQuery.of(context).size.height/15.1,
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

                      if (hikeName.text != "" || hikeType.text != "" || miles.text != "") {
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
    
                        //temp.pushAddHike(hikeName.text, hikeType.text, miles.text);
                        temp.pushAddDoneHike(hikeName.text, hikeType.text, miles.text,longitude.text, latitude.text, tripDescription.text, dateCompleted.text);
                        temp.deleteHikeFromToDoPage(doc['Title']);
                        hikeName.text = "";
                        hikeType.text = "";
                        miles.text = "";
                        Navigator.pop(context);
                        Scaffold.of(context).showSnackBar(SnackBar( content: Text('Hike was moved to the done page')));
                      }
                      
                      else if(hikeName.text == "" && hikeType.text == "" && miles.text == ""){
                        print("hikeName = " + hikeName.text + ", hikeType = " + hikeType.text + ", miles = " + miles.text);
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
                     
                    },
                    
                  ),
                  
                ],
              ),
            ),
            ),
          );
        });
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
                        title: toDoHikeCardMaker(
                            document['Title'], document['Type'], document['Miles'])),
                  ),
                  actions: <Widget>[
                    new IconSlideAction(
                      caption: 'Done',
                      color: Colors.blue,
                      icon: Icons.check,
                      onTap: ()  { 
                        openAlertBoxForDone(document['Title'],document['Type'], document, document['Miles']);
                        //Database temp = new Database();
                        //temp.pushAddDoneHike(document['Title'], document['Type'], document['Miles']);
                        //temp.deleteHikeFromToDoPage(document['Title']);
                        //Scaffold.of(context).showSnackBar(SnackBar( content: Text('Hike was moved to the done page')));
                        },
                    ),
                    new IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                      onTap: () { Share.share("This is a test");}    
                    ),
                  ],
                  secondaryActions: <Widget>[
                    new IconSlideAction(
                      caption: 'Edit',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                      onTap: () {openAlertBox(document['Title'],document['Type'], document, document['Miles'],);},
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
