import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Home.dart';
import 'Database.dart';

List<DocumentSnapshot> doneHikesReturn;
List<DocumentSnapshot> otherUser;

class NewMapPage extends StatefulWidget {
  NewMapPageState createState() {
    return NewMapPageState();
  }
}

class NewMapPageState extends State<NewMapPage> {
  void initState() {
    super.initState();
    _userMakers();
  }

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(47.6062, -122.3321);

  Set<Marker> _markers = {};

  MapType _currentMapType = MapType.terrain;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.terrain
          ? MapType.satellite
          : MapType.terrain;
    });
  }

  void _onAddMarkerButtonPressed(DocumentSnapshot doc) {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(doc.data['Title']),
        position: LatLng(double.parse(doc.data['Latitude']),
            double.parse(doc.data['Longitude'])),
        infoWindow: InfoWindow(
          title: doc.data['Title'],
          snippet: doc.data['Miles'] + " mile(s)\t" + doc.data['Date'],
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    print(_markers);
  }

  _userMakers() async {
    Database temp = new Database();
    var something = await temp.userMarkers();
    setState(() {
      doneHikesReturn = something.documents;
    });

    doneHikesReturn.forEach((doc) => _onAddMarkerButtonPressed(doc));
  }

  _otherUserMakers(String userName) async {
    Database temp = new Database();
    var something = await temp.otherUserMarkers(userName);
    setState(() {
      otherUser = something.documents;
    });

    doneHikesReturn.forEach((doc) => _onAddMarkerButtonPressed(doc));
  }

  /*LatLng _lastMapPosition = _center;
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }*/

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              //onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: light_dark,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SomeOtherClass()));
                      },
                      child: Icon(
                        Icons.add,
                      ),
                      heroTag: "HikerNamesTag",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SomeOtherClass extends StatefulWidget {
  SomeOtherClassState createState() {
    return SomeOtherClassState();
  }
}

class SomeOtherClassState extends State<SomeOtherClass> {
  Widget userNameButtons = new Container(
    child: new Column(
      //mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text("Name 1", style: new TextStyle(fontSize: 16.0)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text("Name 2", style: new TextStyle(fontSize: 16.0)),
        ),
        new Text("Name 3", style: new TextStyle(fontSize: 16.0)),
        new Text("Name 4", style: new TextStyle(fontSize: 16.0)),
        new Text("Name 5", style: new TextStyle(fontSize: 16.0)),
        new Text("Name 5", style: new TextStyle(fontSize: 16.0)),
        new Text("Name 5", style: new TextStyle(fontSize: 16.0)),
        new Text("Name 5", style: new TextStyle(fontSize: 16.0)),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: light_dark,
        title: new Text("View other hikers completed hikes"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Hero(
          tag: "HikerNamesTag",
          transitionOnUserGestures: true,
          child: Material(
            color: Colors.white,
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: userNameButtons,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
