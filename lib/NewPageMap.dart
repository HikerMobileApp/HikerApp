import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Database.dart';


var myKey = 'AIzaSyB_2tJ1sapz6JjEYRCA2fVYQc6TM_LbMAI';
List<DocumentSnapshot> doneHikesReturn;





class NewPageMap extends StatefulWidget {
  NewPageMapState createState() {
    MapView.setApiKey(myKey);
    return NewPageMapState();
  }
}

class NewPageMapState extends State<NewPageMap> {
  MapView mapView = new MapView();

  void initState() {
    super.initState();
    _userMakers();
  }
  

  List<Marker> markers = [
    new Marker("1", "Name of Hike", 20.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("2", "Name of Hike", 30.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("3", "Name of Hike", 40.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("4", "Name of Hike", 50.2672, -97.7431, color: Colors.blue, draggable: true)
  ]; 

  _userMakers() async {
  Database temp = new Database();
    var something =await temp.userMarkers();
    setState(() {
      doneHikesReturn =something.documents;
    });
  }  


  displayMap() {
    mapView.show(new MapOptions(
      mapViewType: MapViewType.normal,
      initialCameraPosition: new CameraPosition(new Location(47.6062, -122.3321), 8.0),
      showUserLocation: true,
      title: 'Hike Locator',
    ));
    mapView.onMapTapped.listen((tapped) {
      //call the database class to let all the lgn and lat to put in the markers
      mapView.setMarkers(markers);
      mapView.zoomToFit(padding: 100);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
              backgroundColor: light_dark,
              title: new Text("Hike Locator"),
              actions: <Widget>[],
            ),
      body: new Column(
        children: <Widget>[
          new Container(
            height: 500.0,
            width: 350.0,
            child: new Stack(
              children: displayMap(),
            ),
          ),
        ],
      ),
    );

  }
}