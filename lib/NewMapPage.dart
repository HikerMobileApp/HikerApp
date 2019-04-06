import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Home.dart';
import 'Database.dart';

List<DocumentSnapshot> doneHikesReturn;

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

  _otherUserMakers() async {
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
                      heroTag: "demoTag",
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

// The base class for the different types of items the List can contain
abstract class ListItem {}

// A ListItem that contains data to display a heading
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

// A ListItem that contains data to display a message
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}

final items = List<ListItem>.generate(
  1200,
  (i) => i % 6 == 0
      ? HeadingItem("Heading $i")
      : MessageItem("Sender $i", "Message body $i"),
);

class SomeOtherClassState extends State<SomeOtherClass> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build
      itemCount: items.length,
      // Provide a builder function. This is where the magic happens! We'll
      // convert each item into a Widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is HeadingItem) {
          return ListTile(
            title: Text(
              item.heading,
              style: Theme.of(context).textTheme.headline,
            ),
          );
        } else if (item is MessageItem) {
          return ListTile(
            title: Text(item.sender),
            subtitle: Text(item.body),
          );
        }
      },
    );
  }
}
