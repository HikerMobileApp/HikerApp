import 'package:flutter/material.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Database.dart';
import 'Constants.dart';
import 'package:share/share.dart';

const Color myColor = Color(0xff243447);

class NewPageDone extends StatefulWidget {
  NewPageDoneState createState() {
    return NewPageDoneState();
  }
}

class NewPageDoneState extends State<NewPageDone> {
  //alert box
  //alert box
  final hikeName = TextEditingController();
  final hikeType = TextEditingController();
  final miles = TextEditingController();
  final longitude = TextEditingController();
  final latitude = TextEditingController();
  final tripDescription = TextEditingController();
  final dateCompleted = TextEditingController();
  openAlertBox(String  title, String description, DocumentSnapshot doc, String mil, String lat, String lng, String date, String tripDes) {
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
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: mil,
                        border: InputBorder.none,
                      ),
                      controller: miles,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      decoration: InputDecoration(
                        hintText: lng,
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
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                      decoration: InputDecoration(
                        hintText: lat,
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
                        hintText: tripDes,
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
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: date,
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

                      if (hikeName.text != "" || hikeType.text != ""|| miles.text != "" || latitude.text != "" || longitude.text != "" ||  tripDescription.text != "" || dateCompleted.text != "") {
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
                        if(latitude.text == ""){
                          latitude.text = lat;
                        }
                        if(longitude.text == ""){
                          longitude.text = lng;
                        }
                        if(tripDescription.text == ""){
                          tripDescription.text = tripDes;
                        }
                        if(dateCompleted.text == ""){
                          dateCompleted.text = date;
                        }
                        temp.pushAddDoneHike(hikeName.text, hikeType.text, miles.text,longitude.text, latitude.text, tripDescription.text, dateCompleted.text);
                        temp.deleteHikeFromDonePage(doc['Title']);
                        hikeName.text = "";
                        hikeType.text = "";
                        miles.text = "";
                        latitude.text = "";
                        longitude.text = ""; 
                        tripDescription.text = "";
                        dateCompleted.text = "";
                        Navigator.pop(context);
                      }
                      else {
                        hikeName.text =title;
                        hikeType.text =description;
                        miles.text = mil;
                        longitude.text = lng;
                        latitude.text = lat;
                        tripDescription.text = tripDes;
                        dateCompleted.text = date;

                        print("Fields Left Empty");
                        Database temp = new Database();
                        temp.pushAddDoneHike(hikeName.text, hikeType.text, miles.text,longitude.text, latitude.text, tripDescription.text, dateCompleted.text);
                        hikeName.text = "";
                        hikeType.text = "";
                        miles.text = "";
                        latitude.text = "";
                        longitude.text = ""; 
                        tripDescription.text = "";
                        dateCompleted.text = "";
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
                return new Slidable(
                  delegate: new SlidableDrawerDelegate(),
                  actionExtentRatio: 0.25,
                  child: new Container(
                    color: Colors.transparent,
                    child: new ListTile(
                        title: doneHikeCardMaker(
                            document['Title'], document['Type'], document['Miles'], document['Description'] ,document['Longitude'], document['Latitude'], document['Date']
                            )
                            ),
                  ),
                  actions: <Widget>[
                    new IconSlideAction(
                      caption: 'More',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () {},
                    ),
                    new IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                      onTap: () { Share.share("This is a test");},
                    ),
                  ],
                  secondaryActions: <Widget>[
                    new IconSlideAction(
                      caption: 'Edit',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                      onTap: () {openAlertBox(document['Title'], document['Type'], document, document['Miles'],document['Latitude'], document['Longitude'], document['Date'], document['Description']);},
                    ),
                    new IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        Database temp = new Database();
                        temp.deleteHikeFromDonePage(document['Title']);
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Deleted')));
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
