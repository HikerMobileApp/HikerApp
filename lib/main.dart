import 'package:flutter/material.dart'; 
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'NewPageDone.dart';
import 'NewPageToDo.dart';
import 'HikeCard.dart';
import 'AddHikePage.dart';
import 'Root.dart';
import 'auth.dart';

const Color dark_green = Color(0xff141d26);
const Color light_dark = Color(0xff243447);

void main() => runApp( new MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: new ThemeData(
    accentColor: Colors.greenAccent,
    hintColor: Colors.greenAccent,
    canvasColor: light_dark,
  ),
  home:  RootPage(auth: Auth()),
  
));
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState(){
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
    Drawer drawer = new Drawer();
    return new Scaffold(
      key: globalKey,
      drawer: drawer,
      appBar: new AppBar(title: new Text("Home"), elevation: 5.0, backgroundColor: dark_green,
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
        children: <Widget>[new NewPageToDo("todo"), new NewPageDone("done")],
        controller: tabController,
      ),
      bottomNavigationBar: new Material(
        //color: jade_blue,
        color: dark_green,
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
