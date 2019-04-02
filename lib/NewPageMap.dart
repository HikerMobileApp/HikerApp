import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  

  List<Marker> markers = [
    /*new Marker("1", "Name of Hike", 20.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("2", "Name of Hike", 30.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("3", "Name of Hike", 40.2672, -97.7431, color: Colors.blue, draggable: true),
    new Marker("4", "Name of Hike", 50.2672, -97.7431, color: Colors.blue, draggable: true)*/
  ]; 

  Widget loadMarker() {
    print("IN THE LOAD MARKER METHOD");
    return StreamBuilder(
      stream: Firestore.instance.collection(globalUserName).document('Done Hikes').collection('Hike List').snapshots(),
      builder: (context, snapshot) {
        print("IN THE BUILDER METHOD");
        if(snapshot.hasError) {
          print(snapshot.error);
        }
        if(!snapshot.hasData) return Text('Loading markers');
        for(int i=0; i < snapshot.data.document.length; i++) {
          int num = i + 1;
          print("$num");
          print(snapshot.data.document['Title']);
          print(snapshot.data.document['Latitude']);
          print(snapshot.data.document['Longitude']);
          markers.add(new Marker("$num",snapshot.data.document['Title'], 
                                      snapshot.data.document['Latitude'], 
                                      snapshot.data.document['Longitude']));
        }
      }, 
    );
  }

  displayMap() {
    loadMarker();
    mapView.show(new MapOptions(
      mapViewType: MapViewType.normal,
      initialCameraPosition: new CameraPosition(new Location(47.6062, -122.3321), 8.0),
      showUserLocation: true,
      title: 'Hike Locator',
    ));
    //mapView.setMarkers(markers);
    //mapView.zoomToFit(padding: 100);
    mapView.onMapTapped.listen((tapped) {
      //call the database class to let all the lgn and lat to put in the markers
      loadMarker();
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