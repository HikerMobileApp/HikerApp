import 'package:flutter/material.dart'; 
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'NewPageDone.dart';
import 'NewPageToDo.dart';
import 'HikeCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


const Color dark_green = Color(0xff027206);
const Color jade_blue = Color(0xff339192);

List<Widget> cards = new List.generate(20, (i)=>new HikeCard());
String hikeName;
String typeOfHike;

void main() => runApp( new MaterialApp(
  theme: new ThemeData(
    accentColor: Colors.green,
    hintColor: Colors.green
  ),
  home: new HomePage(),
  
));

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState(){
    //Firestore.instance.collection('Hikes').document().setData({ 'Title': 'Jade Hike', 'Type': '20 Miles' });

    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Hiker"), elevation: 0.0, backgroundColor: dark_green,), 
      body: new TabBarView(
        children: <Widget>[new NewPageToDo("todo"), new NewPageDone("done")],
        controller: tabController,
      ),
      bottomNavigationBar: new Material(
        //color: jade_blue,
        color: dark_green,
        child: new TabBar(
          indicatorColor: Colors.green,
          controller: tabController,
          tabs: <Widget>[
            new Tab(
             //icon: new Icon(Icons.bookmark),
             //icon: new Icon(Icons.directions_walk),
              icon: new Icon(MdiIcons.walk),
            ),
            new Tab(
              //icon: new Icon(Icons.beenhere),
              icon: new Icon(Icons.done),
            )
          ],
        ),

      ),
    );
  }
}



class HikeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Hikes').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['Title']),
                  subtitle: new Text(document['Type']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}