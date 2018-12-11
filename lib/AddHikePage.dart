import 'package:flutter/material.dart';
import 'main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Database.dart';

class AddHikePage extends MaterialPageRoute<Null> {
  AddHikePage()
      : super(builder: (BuildContext context) {
          final hikeName = TextEditingController();
          final hikeType = TextEditingController();
          final miles = TextEditingController();

          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: light_dark,
              title: new Text("Add a hike"),
              actions: <Widget>[
                new IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      if (hikeName.text != "" && hikeType.text != "") {
                        String user = FirebaseAuth.instance.currentUser().toString();
                        Database temp = new Database();
                        temp.pushAddHike(user, hikeName.text, hikeType.text);
                      }
                      Navigator.pop(context);
                    })
              ],
            ),
            body: new Form(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(MdiIcons.walk, color: Colors.white),
                    title: new TextFormField(
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                      decoration: new InputDecoration(
                        labelText: 'Hike Name',
                        hintText: "Name your hike",
                      ),
                      controller: hikeName,
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(MdiIcons.pen, color: Colors.white),
                    title: new TextFormField(
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                      decoration: new InputDecoration(
                        labelText: 'Hike Type',
                        hintText: "Describle your hike",
                      ),
                      controller: hikeType,
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(MdiIcons.note, color: Colors.white,),
                    title: new TextFormField(
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                      decoration: new InputDecoration(
                        labelText: 'Miles',
                        hintText: "How Many Miles?",
                      ),
                      controller: miles,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
}
