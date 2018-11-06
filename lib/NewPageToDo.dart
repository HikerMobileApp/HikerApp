import 'package:flutter/material.dart'; 
import 'main.dart';
import 'Home.dart';


class NewPageToDo extends StatelessWidget{
  
  final String title;
  NewPageToDo(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
     // backgroundColor: dark_green,
      //floatingActionButton: FloatingActionButton(
     // backgroundColor: jade_blue, onPressed: (){
     //   Navigator.push(context, AddHikePage());
     // }
     //   , child: Icon(Icons.add),
    //),
       body: new Container(
              child: new ListView(
                children: cards,
              )
            ) 
    );
}
}