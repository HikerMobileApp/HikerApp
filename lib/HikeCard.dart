import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

Icon leadingIcon;
String icon;
File _image;
String filename;

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



/*Card doneHikeCardMaker(String hikeName, String hikeType, String miles,
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

  Future _getImage() async {
    var selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    setState((){
        _image = selectedImage;
        filename = basename(_image.path);
    });
    
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
                  height: 400.0,
                  width: 300.0,
                  child: _image == null
                  ? new Carousel(
                    images: [
                      new NetworkImage('https://golutes.com/images/2018/12/11/TF_Scheel_web.jpg?width=300'),
                      new NetworkImage('https://a2-images.myspacecdn.com/images03/33/b98cedc7bf1d42339c9d37ec03ab1fbc/300x300.jpg'),
                      
                    
                      
                    ],
                  )
                  : new Carousel(
                    images: [
                      new NetworkImage('https://golutes.com/images/2018/12/11/TF_Scheel_web.jpg?width=300'),
                      new NetworkImage('https://a2-images.myspacecdn.com/images03/33/b98cedc7bf1d42339c9d37ec03ab1fbc/300x300.jpg'),
                      new FileImage(_image),
                      
                    
                      
                    ],
                  ),
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
*/


