import 'package:flutter/material.dart'; 
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'NewPageDone.dart';
import 'NewPageToDo.dart';
import 'HikeCard.dart';
import 'AddHikePage.dart';

const Color dark_green = Color(0xff141d26);
const Color light_dark = Color(0xff243447);

//List<Widget> cards = new List.generate(5, (i)=>new HikeCard());
String hikeName;
String typeOfHike;
final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState(){
    super.initState();
    //Firestore.instance.collection('Hiking').document()
    //.setData({'Title': 'Jade Lake', 'Type': 'Backpacking'});
    tabController = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    Drawer drawer = new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            //accountName: new Text("Isaiah Scheel"),
            //accountEmail: new Text("isaiahscheel@gmail.com"),
            //currentAccountPicture: new Icon(Icons.account_circle),
            child: new CircleAvatar(),
          )
        ],
      ),
    );
    return new Scaffold(
      key: globalKey,
      drawer: drawer,
      appBar: new AppBar(title: new Text("Home"), elevation: 5.0, backgroundColor: light_dark,
      leading: new IconButton(
          icon: new Icon(Icons.account_circle),
          onPressed: () {
            //Navigator.push(context, AddHikePage());
            globalKey.currentState.openDrawer();
          }
        ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, AddHikePage());
          }
        ),
      ]), 
      body: new TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[new NewPageToDo(), new NewPageDone("done")],
        controller: tabController,
      ),
      bottomNavigationBar: new Material(
        //color: jade_blue,
        color: light_dark,
        child: new TabBar(
          indicatorColor: Colors.white,
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
