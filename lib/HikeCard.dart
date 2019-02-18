import 'package:flutter/material.dart';
import 'Database.dart';


//class HikeCard(String hikeName, string hikeType, int elevation, String location){
//
//}

Card hikeCardMaker(String hikeName, String hikeType, String miles){
  return new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
            leading:  Icon(Icons.directions_walk),
            title:  Text(hikeName),
            subtitle:  Text(miles + ' mile ' + hikeType),
            ),
            new ButtonTheme.bar(
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('DONE', style: TextStyle(color: Colors.blueGrey)),
                    onPressed: () {
                      Database temp = new Database();
                      temp.pushAddDoneHike(hikeName, hikeType);
                      temp.deleteHikeFromToDoPage(hikeName);
                      }
                  ),
                  new FlatButton(
                    child: const Text('DELETE', style: TextStyle(color: Colors.blueGrey)),
                    onPressed: () {
                      Database temp = new Database();
                      temp.deleteHikeFromToDoPage(hikeName);
                    }
                  ),
                ],
              )
            )
          ]
        )
      );

}
class HikeCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
            leading: const Icon(Icons.directions_walk),
            title: const Text('Jade Lake'),
            subtitle: const Text('20 mile Backpacking'),
            ),
            new ButtonTheme.bar(
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: const Text('DONE', style: TextStyle(color: Colors.blueGrey),),
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
