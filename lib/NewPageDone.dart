import 'dart:async';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart' as Path;
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
Icon leadingIcon;
String icon;
File _image;
String filename;

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
                        title: doneHikeCardMaker(document,
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
  Card doneHikeCardMaker(DocumentSnapshot doc,String hikeName, String hikeType, String miles,
    String des, String long, String lat, String date) {
  if (hikeType == "Multi-Night") {
    icon = "weatherNight";
  } else if (hikeType == "Day Hike") {
    icon = "walk";
  } else if (hikeType == "Backpacking") {
    icon = "tent";
  } else {
    icon = "pineTree";
  }
  Future<String> uploadImage() async{
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(_image);

    var downUrl = await( await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    
    return url;
  }

  Future _getImage() async {
    var selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    setState((){
        _image = selectedImage;
        filename = Path.basename(_image.path);
    });
    String downloadURL = await uploadImage();
     Database temp = new Database();
     if(doc['url1'] == null)
     temp.pushImageOne(downloadURL,hikeName);
     else if(doc['url2'] == null)
     temp.pushImageTwo(downloadURL,hikeName);
     else if(doc['url3'] == null)
     temp.pushImageThree(downloadURL,hikeName);
     else{
       print("__________________________________NO MAS IMAGES___________________________");
     }
     print("______________________________NEW URL _____________________________________"+ doc['url1']);
  }


  return new Card(
    child: ExpandableNotifier(
      controller: ExpandableController(false),
      child: new Column(
        mainAxisSize: MainAxisSize.min, 
        children: <Widget>[
          Expandable(
            collapsed: 
            ListTile(
              leading: Icon(MdiIcons.fromString(icon)),
              title: Text(hikeName),
              subtitle: Text(miles +
                  ' mile(s)\t Type: ' +
                  hikeType +
                  '\nTrip Description: ' +
                  des +
                  '\nLongitude: ' +
                  long +
                  ', Latitude: ' +
                  lat +
                  '\nDate: ' +
                  date),
            ),
            expanded: 
            
            ListTile(
                leading: Icon(MdiIcons.fromString(icon)),
                title: 
                new SizedBox(
                  height: 200,
                  width: 300.0,
                  
                  child:
                  new Carousel(
                    showIndicator: false,
                    autoplayDuration: const Duration(seconds: 8),
                    images: [
                      doc['url1'] != null? new NetworkImage(doc['url1']): new NetworkImage('https://i.imgur.com/fHpLsZc.png'),
                      doc['url2'] != null? new NetworkImage(doc['url2']): new NetworkImage('https://i.imgur.com/fHpLsZc.png'),
                      doc['url3'] != null? new NetworkImage(doc['url3']): new NetworkImage('https://i.imgur.com/fHpLsZc.png'),
                    
                      
                    ],
                  )
                  
                  ),
                trailing:FloatingActionButton(
                  onPressed: _getImage,
                  tooltip: 'Pick Image',
                  child: Icon(Icons.add_a_photo),
                ),
                 
              
                

              
            ), 
          ),
    
    Divider(
      height: 0.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Builder(
          builder: (context){
            var exp = ExpandableController.of(context);
            return MaterialButton(
              child: Text(exp.expanded ?"Info": "Photos",
              style: Theme.of(context).textTheme.button.copyWith(
                color:Colors.lightGreen
              ),
              ),
              onPressed: (){
                exp.toggle();
              },
            );
          }
        )
      ],)


  ])));
}

}

