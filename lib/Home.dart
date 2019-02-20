import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'NewPageDone.dart';
import 'NewPageToDo.dart';
import 'AddHikePage.dart';
import 'auth.dart';
import 'Constants.dart';
import 'Root.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    //_loadUsername();
    Drawer drawer = new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: light_dark
              
            ),
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
                  fit: BoxFit.fill,
                  image: new NetworkImage(img)
                 )
                  )),
      
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
              _setUsername("Signed Out");
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
              icon: new CircleAvatar(
               backgroundImage: NetworkImage(img),
              ),
              
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
        children: <Widget>[new NewPageToDo(), new NewPageDone()],
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
