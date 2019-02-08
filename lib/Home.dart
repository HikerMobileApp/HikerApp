import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'NewPageDone.dart';
import 'NewPageToDo.dart';
import 'AddHikePage.dart';
import 'auth.dart';
import 'Constants.dart';
import 'Root.dart';

const Color dark_green = Color(0xff141d26);
const Color light_dark = Color(0xff243447);

//List<Widget> cards = new List.generate(5, (i)=>new HikeCard());
String hikeName;
String typeOfHike;
final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  String img = "";
  @override
  void initState() {
    super.initState();
    //Firestore.instance.collection('Hiking').document()
    //.setData({'Title': 'Jade Lake', 'Type': 'Backpacking'});
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Drawer drawer = new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            //accountName: new Text("Isaiah Scheel"),
            //accountEmail: new Text("isaiahscheel@gmail.com"),
            //currentAccountPicture: new Icon(Icons.account_circle),
            child: Container(
              height: 350.0,
              width: 350.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  //fit: BoxFit.fill,
                  image: NetworkImage(
                      'http://logo.pizza/img/dog-profile/dog-profile.png'),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
              size: 20,
            ),
            title: Text('Profile',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 20,
            ),
            title: Text('Friends',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.list,
              color: Colors.white,
              size: 20,
            ),
            title: Text('Lists',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: 20,
            ),
            title: Text('Privacy and Settings',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white)),
            onTap: () {
              print("globalUserName: " + globalUserName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 20,
            ),
              title: Text('Sign Out',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white)),
            onTap: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext) => RootPage(auth: Auth())));
            },
          ),
        ],
      ),
    );
    return new Scaffold(
      key: globalKey,
      drawer: drawer,
      appBar: new AppBar(
          title: new Text("Home"),
          elevation: 5.0,
          backgroundColor: light_dark,
          leading: new IconButton(
              icon: new Icon(Icons.account_circle),
              onPressed: () {
                //img = returnProfilePic();
                print(img);
                if (img == ' ') {
                  img = 'http://logo.pizza/img/dog-profile/dog-profile.png';
                }
                globalKey.currentState.openDrawer();
              }),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, AddHikePage());
                }),
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
