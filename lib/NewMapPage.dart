import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Home.dart';
import 'Database.dart';

List<DocumentSnapshot> doneHikesReturn;
List<DocumentSnapshot> otherUser;
Set<Marker> _markers = {};

class NewMapPage extends StatefulWidget {
  NewMapPageState createState() {
    return NewMapPageState();
  }
}

class NewMapPageState extends State<NewMapPage> {
  void initState() {
    _markers.clear();
    super.initState();
    _userMakers();
  }

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(47.6062, -122.3321);


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
    //print(_markers);
  }

  _userMakers() async {
    Database temp = new Database();
    var something = await temp.userMarkers();
    setState(() {
      doneHikesReturn = something.documents;
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
                      mini: true,
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: light_dark,
                      //child: const Icon(Icons.map, size: 36.0),
                      child: const Icon(Icons.map),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      mini: true,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SomeOtherClass()));
                      },
                      
                      backgroundColor: light_dark,
                      child: Icon(
                        Icons.group,
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
  void _onAddMarkerButtonPressed(DocumentSnapshot doc, String userName, String picId) {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(doc.data['Title']),
        position: LatLng(double.parse(doc.data['Latitude']),
            double.parse(doc.data['Longitude'])),
        infoWindow: InfoWindow(
          title: doc.data['Title'],
          snippet: userName +"\n"+ doc.data['Miles'] + " mile(s)\t" + doc.data['Date'],
        ),
        //try to make it his facebook picture
        // add the url to the database
        //makes it easier to get the picture
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    });
  }

  _otherUserMakers(String userName, String picId) async {
    Database temp = new Database();
    var something = await temp.otherUserMarkers(userName);
    setState(() {
      otherUser = something.documents;
    });
    otherUser.forEach((doc) => _onAddMarkerButtonPressed(doc, userName, picId));
    //print(otherUser);
  }

  Database temp = new Database();
  Card profileCard(String name, var miles, String profPic) {
      if (miles == null) {
        miles = 0;
      }
      if (profPic == "") {
        profPic =
            "https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg";
      }
      return new Card(
          child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(profPic)),
          title: Text(name),
          subtitle: new Text("Miles Hiked: " + miles.toString()),
          //subtitle:  Text(miles + ' mile ' + hikeType),
        ),
      ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: light_dark,
          title: new Text("View other hikers completed hikes"),
        ),
        body: new Column(children: <Widget>[
          new Flexible(
            child: new Hero(
                tag: "HikerNamesTag",
                transitionOnUserGestures: true,
                child: StreamBuilder(
                    stream: Firestore.instance.collection("USERS").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        );
                      }
                      return ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          reverse: false,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, int index) {
                            String user =
                                snapshot.data.documents[index]["Name"];
                            var miles =
                                snapshot.data.documents[index]["MilesHiked"];
                            String profPic =
                                snapshot.data.documents[index]["profilePic"];
                            return new GestureDetector(
                              onTap: () {
                                _otherUserMakers(user, profPic);
                                Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(user + "s hikes added to the map")));
                            //Navigator.pop(context);
                            
                              },
                              child: profileCard(user, miles, profPic),
                            );
                          });
                    })),
          ),
        ]));
  }
}
