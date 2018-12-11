import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Database{

  //I need to rethink this to a bool
  void pushAddHike(String user, String hikeName, String hikeType)
  {
    Firestore.instance
    .collection(user)
    .document("Hikes To Do")
    .collection("Hike List")
    .document(hikeName)
    .setData({'Title': hikeName,'Type': hikeType});
  }

  void pullHikes()
  {
    String user = FirebaseAuth.instance.currentUser().toString();
    CollectionReference collectionRef = Firestore.instance
    .collection(user)
    .document("Hikes To Do")
    .collection("Hike List");

    collectionRef.getDocuments();


  Future <List<Map<dynamic, dynamic>>> getCollection() async{
  List<DocumentSnapshot> templist;
  List<Map<dynamic, dynamic>> list = new List();
  CollectionReference collectionRef = Firestore.instance.collection(user)
                                                        .document("Hikes To Do")
                                                        .collection("Hike List");
  QuerySnapshot collectionSnapshot = await collectionRef.getDocuments();

  templist = collectionSnapshot.documents; // <--- ERROR

  list = templist.map((DocumentSnapshot docSnapshot){
    return docSnapshot.data;
  }).toList();

  return list;
}  

  }
}