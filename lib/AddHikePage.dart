import 'package:flutter/material.dart';
import 'main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'Database.dart';

class AddHikePage extends StatefulWidget {
  @override
  _AddHikePage createState() => new _AddHikePage();
}
class _AddHikePage extends State<AddHikePage>{

          final hikeName = TextEditingController();
          final hikeType = TextEditingController();
          final miles = TextEditingController();
          String dropdownValue;
          String hike;
          String _currentHike;

            List _hikeTypes =
            ["Day Hike", "Backpacking", "Multi-Night"];

            List<DropdownMenuItem<String>> _dropDownMenuItems;

            @override
            void initState() {
              _dropDownMenuItems = getDropDownMenuItems();
              //_currentCity = _dropDownMenuItems[0].value;
              super.initState();
            }

            List<DropdownMenuItem<String>> getDropDownMenuItems() {
              List<DropdownMenuItem<String>> items = new List();
              for (String hike in _hikeTypes) {
                items.add(new DropdownMenuItem(
                    value: hike,
                    child: new Text(hike, style: TextStyle(color: Colors.greenAccent),)
                ));
              }
              return items;
            }

            void changedDropDownItem(String selectedHike) {
              setState(() {
                _currentHike = selectedHike;
              });
            }

Widget build(BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: light_dark,
              title: new Text("Add a hike"),
              actions: <Widget>[
                new IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      if (hikeName.text != "" && _currentHike != "") {
                        print("Checkmark clicked");
                        Database temp = new Database();
                        temp.pushAddHike(hikeName.text, _currentHike, miles.text);
                      }
                      else if(hikeName.text == "" && hikeType.text == ""){
                        print("Fields Left Empty");
                        Database temp = new Database();
                        temp.pushAddHike("test6", "test6", "5");
                      }
                      else{
                        print("idk what is happening but isaiah is a cool guy   ");
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
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                      decoration: new InputDecoration(
                        labelText: 'Hike Name',
                        hintText: "Name your hike",
                      ),
                      controller: hikeName,
                    ),
                  ),
                  new ListTile(
                    //leading: const Icon(MdiIcons.note, color: Colors.white,),
                    leading: const Icon(MdiIcons.gnome, color: Colors.white),
                    title: new TextFormField(
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                      decoration: new InputDecoration(
                        labelText: 'Miles',
                        hintText: "How Many Miles?",
                      ),
                      controller: miles,
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(MdiIcons.pineTree, color: Colors.white),
                    
                    title:  new DropdownButton(
                        hint: new Text("Hike Type"),
                        value: _currentHike,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                  ),
                ],
              ),
            ),
          );
        }
}
