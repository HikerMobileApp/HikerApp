import 'package:flutter/material.dart';
import 'main.dart';

class NewPageDone extends StatelessWidget {
  final String title;
  NewPageDone(this.title);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: dark_green,
      body: new Center(
          child: new Text(
        "Click done on a hike for it to show here",
        style:
            new TextStyle(fontWeight: FontWeight.bold, color: Colors.white24),
      )),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
