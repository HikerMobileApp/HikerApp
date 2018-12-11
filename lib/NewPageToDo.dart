import 'package:flutter/material.dart';
import 'HikeCard.dart'; 

class NewPageToDo extends StatefulWidget{
  
  NewPageToDoState createState(){
    return NewPageToDoState();
  }
}
class NewPageToDoState extends State<NewPageToDo>{
  static Card card1 = hikeCardMaker('Jade Lake', 'Backpacking', '20');
  static Card card2 = hikeCardMaker('Panarama Point', 'Day Hike', '5');
  static Card card3 = hikeCardMaker('Tuck and Robin Lake', 'Backpacking', '12');
  static Card card4 = hikeCardMaker('Poo Poo Point', 'Day Hike', '6');
  static Card card5 = hikeCardMaker('Matterhorn', 'Backpacking', '16');
  List<Widget> cards = [card1, card2, card3, card4, card5];
  

  @override
  Widget build(BuildContext context) {
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
                     child: ListTile(title: card),
                  );
                }
              )
       )
    );
}
}
