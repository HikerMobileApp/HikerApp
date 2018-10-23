import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
const Color dark_green = Color(0xff027206);
const Color jade_blue = Color(0xff339192);

List<Widget> cards = new List.generate(20, (i)=>new HikeCard());
String hikeName;
String typeOfHike;

void main() => runApp( new MaterialApp(
  theme: new ThemeData(
    accentColor: Colors.teal,
    hintColor: Colors.teal,
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

class NewPageToDo extends StatelessWidget{
  
  final String title;
  NewPageToDo(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: dark_green,
      floatingActionButton: FloatingActionButton(
      backgroundColor: jade_blue, onPressed: (){
        //Navigator.push(context, AddHikePage());
      }
        , child: Icon(Icons.add),
    ),
       body: new Container(
              child: new ListView(
                //children: cards,
              )
            ) 
    );
}
}

class NewPageDone extends StatelessWidget{
  final String title;
  NewPageDone(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: dark_green,
      body: new Center(
        child: new Text("Click done on a hike for it to show here", style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white24),)
        ),
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

class AddHikePage extends MaterialPageRoute<Null>{
  AddHikePage(): super( builder: (BuildContext context){
    return new Scaffold(
  appBar: new AppBar(
    backgroundColor: dark_green,
    title: new Text("Add a hike"),
    actions: <Widget>[
      new IconButton(icon: const Icon(Icons.check), onPressed: () {

      })
    ],
  ),
  body: 
  new Form(
    child: new Column(
    children: <Widget>[
      new ListTile(
        leading: const Icon(MdiIcons.walk),
        title: new TextFormField(
          decoration: new InputDecoration(
            hintText: "Name of hike",
          ),
          onSaved: (String value){
            hikeName = value;
          },
            validator: (value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
  },
        ),
      ),
      new ListTile(
        leading: const Icon(MdiIcons.pen),
        title: new TextFormField(
          decoration: new InputDecoration(
            hintText: "Type of Hike",
          ),
          onSaved: (String value){
            typeOfHike = value;
          },
        ),
      ),

    ],
  ),
  ),
    );
  } 
  );
}


class HikeCard extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
            leading: const Icon(Icons.directions_walk),
            title: const Text('jade lake'),
            subtitle: const Text('20 mile Backpacking'),
            ),
            new ButtonTheme.bar(
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('DONE'),
                    onPressed: () {}
                  ),
                  new FlatButton(
                    child: const Text('DELETE'),
                    onPressed: () {}
                  ),
                ],
              )
            )
          ]
        )
      );
  }
}
/*
class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
              return  new Card(
                    child: new Column(
                      children: <Widget>[
                        new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
                        new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Row(
                            children: <Widget>[
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Icon(Icons.thumb_up),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Text('Like',style: new TextStyle(fontSize: 18.0),),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Icon(Icons.comment),
                             ),
                             new Padding(
                               padding: new EdgeInsets.all(7.0),
                               child: new Text('Comments',style: new TextStyle(fontSize: 18.0)),
                             )

                            ],
                          )
                        )
                      ],
                    ),
                  );
  }
}
*/
