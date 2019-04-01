import 'package:flutter/material.dart';



Card statCardMaker(String stat, String data){
  return new Card(
        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                         ListTile(
                          title: Text(stat + ": " + data, textAlign: TextAlign.center
                          ),
                        ),
                      ],
                    ),
      );
}

