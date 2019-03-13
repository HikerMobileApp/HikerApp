import 'package:flutter/material.dart';
import 'Constants.dart';
import 'Database.dart';

//class ProfilePage extends StatefulWidget {
//  @override
//  _ProfilePage createState() => new _ProfilePage();
//}
Database temp = new Database();
class ProfilePage extends MaterialPageRoute<Null> {
  ProfilePage()
  
      : super(builder: (BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.black.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        //Center(
        Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height / 10,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: new NetworkImage(img),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 1.0),
                Text(
                  globalUserName,
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Stats: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 25.0),
                Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          //leading: Icon(Icons.album),
                          title: Text('Hikes Done: '),
                          //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                        ),
                      ],
                    ),
                ),
              ],
            ))
      ],
    ));
  }
      );
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}