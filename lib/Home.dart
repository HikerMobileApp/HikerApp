import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'NewPageDone.dart';
import 'NewPageToDo.dart';
import 'AddHikePage.dart';
import 'auth.dart';
import 'Constants.dart';
import 'Root.dart';
import 'ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'NewMapPage.dart';
import 'Hikers.dart';

const Color dark_green = Color(0xff141d26);
const Color light_dark = Color(0xff243447);

String hikeName;
String typeOfHike;
final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  _setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('username', username);
    });
  }

  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      globalUserName = (prefs.getString('username') ?? "username");
    });
  }

  _loadProfPic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      img = (prefs.getString('profPic') ?? "image");
    });
  }

  TabController tabController;
  String img = "";
  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadProfPic();
    tabController = new TabController(length: 3, vsync: this);
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
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: light_dark),
            accountName: new Text(
              globalUserName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            currentAccountPicture: new Container(
                width: 250.0,
                height: 250.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill, image: new NetworkImage(img)))),
            accountEmail: null,
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.public,
              color: Colors.white,
              size: 20,
            ),
            title: Text('Near Me',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white)),
            onTap: () {
              String url = "https://isaiaher.github.io/";
              launch(url);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.directions_walk,
              color: Colors.white,
              size: 20,
            ),
            title: Text('Hikers',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Hikers()),
              );
            },
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
              String privacyURL =
                  "https://termsfeed.com/privacy-policy/f0d509a98ee4996998b6d545dc1e3afb";
              launch(privacyURL);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.print,
              color: Colors.white,
              size: 20,
            ),
            title: Text('Print GlobalUsername',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.white)),
            onTap: () {
              print(globalUserName);
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
              _setUsername("Signed Out");
              auth.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => RootPage(auth: Auth())));
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
              icon: new CircleAvatar(
                backgroundImage: NetworkImage(img),
              ),
              onPressed: () {
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
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new AddHikePage()));
                }),
          ]),
      body: new TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          new NewPageToDo(),
          new NewPageDone(),
          new NewMapPage()
        ],
        controller: tabController,
      ),
      bottomNavigationBar: Container(
        height: 65.0,
        decoration: BoxDecoration(
          color: Colors.black,
          //border: Border.all(color: Colors.white, width: 1),
          border: Border(top: BorderSide(color: Colors.black, width: 1) ),
        ),
        child: new Material(
          elevation: 20.0,
          color: light_dark,
          child: new TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5.0,
            indicatorColor: Colors.white,
            controller: tabController,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(MdiIcons.walk),
              ),
              new Tab(
                icon: new Icon(Icons.done),
              ),
              new Tab(
                icon: new Icon(Icons.public),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
