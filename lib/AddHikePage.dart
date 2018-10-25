import 'package:flutter/material.dart'; 
import 'main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddHikePage extends MaterialPageRoute<Null>{
  AddHikePage(): super( builder: (BuildContext context){
    return new Scaffold(
  appBar: new AppBar(
    backgroundColor: dark_green,
    title: new Text("Add a hike"),
    actions: <Widget>[
      new IconButton(icon: const Icon(Icons.check), onPressed: () {

        Firestore.instance.collection('Hikes').document().setData({ 'title': 'Robins New Hike', 'Type': 'Your awesome' });

      })
    ],
  ),
  body: 
  new Form(
    child: new Column(
    children: <Widget>[
      new ListTile(
        leading: const Icon(MdiIcons.walk),
        title: new TextFormField(
          decoration: new InputDecoration(
            hintText: "Name of hike",
          ),
          onSaved: (String value){
            hikeName = value;
          },
            validator: (value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
  },
        ),
      ),
      new ListTile(
        leading: const Icon(MdiIcons.pen),
        title: new TextFormField(
          decoration: new InputDecoration(
            hintText: "Type of Hike",
          ),
          onSaved: (String value){
            typeOfHike = value;
          },
        ),
      ),

    ],
  ),
  ),
    );
  } 
  );
}