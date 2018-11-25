import 'package:flutter/material.dart';
import 'HikeCard.dart'; 

class NewPageToDo extends StatefulWidget{
  
  NewPageToDoState createState(){
    return NewPageToDoState();
  }
}
class NewPageToDoState extends State<NewPageToDo>{
  List<Widget> cards = new List.generate(5, (i)=>new HikeCard());
  @override
  Widget build(BuildContext context){
    return new Scaffold(
       body: new Container(
              child: new ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];

                  return Dismissible(
                    key: ObjectKey(card),
                    // We also need to provide a function that tells our app
                    // what to do after an item has been swiped away.
                    onDismissed: (DismissDirection direction) {
                    // Remove the item from our data source.
                    if(direction == DismissDirection.endToStart){
                      
                    
                    setState(() {
                      cards.removeAt(index);
                    });
                    Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$card dismissed")));
                    }
                  }, background: Container(color: Colors.red),
                     child: ListTile(title: card,),
                  );
                }
              )
            ) 
    );
}
}