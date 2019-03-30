import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Database.dart';
import 'Constants.dart';

var myKey = 'AIzaSyB_2tJ1sapz6JjEYRCA2fVYQc6TM_LbMAI';

class NewPageMap extends StatefulWidget {
  NewPageMapState createState() {
    MapView.setApiKey(myKey);
    return NewPageMapState();
  }
}

class NewPageMapState extends State<NewPageMap> {
  MapView mapView = new MapView();
  

  List<Marker> markers = <Marker>[
    new Marker("1", "Name of Hike", 20.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("2", "Name of Hike", 30.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("3", "Name of Hike", 40.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("4", "Name of Hike", 50.2672, -97.7431, color: Colors.blue, draggable: true)
  ]; 

  displayMap() {
    mapView.show(new MapOptions(
      mapViewType: MapViewType.normal,
      initialCameraPosition: new CameraPosition(new Location(47.6062, -122.3321), 10.0),
      showUserLocation: true,
      title: 'Hike Locator'
      
    ));
    //mapView.setMarkers(markers);
    //mapView.zoomToFit(padding: 100);
    mapView.onMapTapped.listen((tapped) {
      mapView.setMarkers(markers);
      mapView.zoomToFit(padding: 100);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text('Maps'),
      ),*/
      body: displayMap() 
      /*new Center(
        child: Container(
          child: RaisedButton(
            child: Text('Tap me'),
            color: Colors.blue,
            textColor: Colors.white,
            elevation: 7.0,
            onPressed: displayMap,
          ),
        ),
      ),*/
    );

  }
}