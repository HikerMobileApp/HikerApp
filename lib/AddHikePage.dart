import 'package:flutter/material.dart'; 
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddHikePage extends MaterialPageRoute<Null>{
  
  AddHikePage(): super( builder: (BuildContext context){
    final hikeName = TextEditingController();  // hike name
    final hikeType = TextEditingController();  // hike type 

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: dark_green,
        title: new Text("Add a hike"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.check), onPressed: () {
        
            if(hikeName.text != "" && hikeType.text != "")
            {   
              Firestore.instance.collection("Hiking").document().setData({'Title': hikeName.text, 'Type': hikeType.text});
              //print(myController.text);
              Navigator.pop(context);
            }
            else if(hikeName.text == "")
            {
              hikeName.text = 'ERROR';
            }
            else if(hikeType.text == "")
            {
              hikeType.text = 'ERROR';
            }

          })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.directions_walk),
            title: new TextField(
              decoration: new InputDecoration(
                labelText: 'Hike Name',
                hintText: "Name your hike",
              ),
              controller: hikeName,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.comment),
            title: new TextField(
              decoration: new InputDecoration(
                labelText: 'Hike Type',
                hintText: "Describe the hike",
              ),
              controller: hikeType,
            ),
          ),
        ],
      ),
    );
  });
}