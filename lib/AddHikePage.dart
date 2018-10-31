import 'package:flutter/material.dart'; 
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddHikePage extends MaterialPageRoute<Null>{
  
  AddHikePage(): super( builder: (BuildContext context){
    final myController = TextEditingController();

    return new Scaffold(
  appBar: new AppBar(
    backgroundColor: dark_green,
    title: new Text("Add a hike"),
    actions: <Widget>[
      new IconButton(icon: const Icon(Icons.check), onPressed: () {
        
        if(myController.text != "")
        {
          Firestore.instance.collection("Hiking").document().setData({'Title': myController.text, 'Type': 'Being HELLA Coool!!!!!!!'});
          //print(myController.text);
          Navigator.pop(context);
        }
      })
    ],
  ),
  body: new Container(
    padding: new EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration( 
          icon: Icon(Icons.directions_walk),
          labelText: 'Hike Name',
          hintText: 'Please enter a search term',
          
        ),
          controller: myController,
      ),
  ),
);
  } 
  );
}