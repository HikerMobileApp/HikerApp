import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
Icon leadingIcon;
String icon;

Card toDoHikeCardMaker(String hikeName, String hikeType, String miles) {
  if (hikeType == "Multi-Night") {
    icon = "weatherNight";
  } else if (hikeType == "Day Hike") {
    icon = "walk";
  } else if (hikeType == "Backpacking") {
    icon = "tent";
  } else {
    icon = "pineTree";
  }
  return new Card(
      child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    ListTile(
      leading: Icon(MdiIcons.fromString(icon)),
      title: Text(hikeName),
      subtitle: Text(miles + ' mile ' + hikeType),
    ),
  ]));
}

Card doneHikeCardMaker(String hikeName, String hikeType, String miles,
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
  return new Card(
      child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
  ]));
}

class HikeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const ListTile(
        leading: const Icon(Icons.directions_walk),
        title: const Text('Jade Lake'),
        subtitle: const Text('20 mile Backpacking'),
      ),
      new ButtonTheme.bar(
          child: new ButtonBar(
        children: <Widget>[
          new FlatButton(
              child: const Text(
                'DONE',
                style: TextStyle(color: Colors.blueGrey),
              ),
              onPressed: () {}),
          new FlatButton(child: const Text('DELETE'), onPressed: () {}),
        ],
      ))
    ]));
  }
}
