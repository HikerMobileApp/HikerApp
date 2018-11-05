import 'package:flutter/material.dart';
import 'main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddHikePage extends MaterialPageRoute<Null> {
  AddHikePage()
      : super(builder: (BuildContext context) {
          final hikeName = TextEditingController();
          final hikeType = TextEditingController();

          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: dark_green,
              title: new Text("Add a hike"),
              actions: <Widget>[
                new IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      /*if (hikeName.text != "" && hikeType.text != "") {
                        Firestore.instance
                            .collection("Hiking")
                            .document()
                            .setData({
                          'Title': hikeName.text,
                          'Type': hikeType.text
                        });
                      }*/

                      Navigator.pop(context);
                    })
              ],
            ),
            body: new Form(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(MdiIcons.walk),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Hike Name',
                        hintText: "Name your hike",
                      ),
                      controller: hikeName,
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(MdiIcons.pen),
                    title: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Hike Type',
                        hintText: "Describle your hike",
                      ),
                      controller: hikeType,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
}
