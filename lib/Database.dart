import 'package:cloud_firestore/cloud_firestore.dart';


class Database{

  void pushAddHike(String user, String hikeName, String hikeType)
  {
    Firestore.instance
    .collection(user)
    .document("Hikes To Do")
    .collection("Hike List")
    .document(hikeName)
    .setData({'Title': hikeName,'Type': hikeType});
  }

}