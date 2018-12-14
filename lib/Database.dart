import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Database{

FirebaseUser mCurrentUser;
FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> pushAddHike(String hikeName, String hikeType) async {
    mCurrentUser = await _auth.currentUser();
    if(mCurrentUser.displayName.toString() == null)
    {
      Firestore.instance
      .collection(mCurrentUser.uid)
      .document("Hikes To Do")
      .collection("Hike List")
      .document(hikeName)
      .setData({'Title': hikeName,'Type': hikeType});
    }
    else
    {
      Firestore.instance
      .collection(mCurrentUser.displayName.toString())
      .document("Hikes To Do")
      .collection("Hike List")
      .document(hikeName)
      .setData({'Title': hikeName,'Type': hikeType});
    }

  }
}