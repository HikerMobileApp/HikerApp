import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Constants.dart';
//import 'package:firebase_core/firebase_core.dart';

class Database {
  Future<void> pushAddHike(String hikeName, String hikeType) async {
    FirebaseUser mCurrentUser = await FirebaseAuth.instance.currentUser();
    int index = mCurrentUser.email.indexOf('@');
    String username = mCurrentUser.email.substring(0, index);
    //username = mCurrentUser.displayName;
    print("Username " + username);
    Firestore.instance
        //.collection(username)
        //.collection("robinkumar123")
        //.collection(globalUser.displayName)
        .collection("Isaiah Scheel")
        .document('Hikes To Do')
        .collection('Hike List')
        .document(hikeName)
        .setData({'Title': hikeName, 'Type': hikeType});
  }

  getProfileImage() async {
    FirebaseUser mCurrentUser = await FirebaseAuth.instance.currentUser();
    mCurrentUser.photoUrl;
  }
}
