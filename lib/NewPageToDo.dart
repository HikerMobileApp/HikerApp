import 'package:flutter/material.dart'; 
import 'Home.dart';


class NewPageToDo extends StatelessWidget{
  
  final String title;
  NewPageToDo(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
       body: new Container(
              child: new ListView(
                children: cards,
              )
            ) 
    );
}
}