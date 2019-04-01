import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Constants.dart';
//import 'package:firebase_core/firebase_core.dart';

class Database {
  Future<void> pushAddHike(String hikeName, String hikeType, String miles) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Hikes To Do')
        .collection('Hike List')
        .document(hikeName)
        .setData({'Title': hikeName, 'Type': hikeType, 'Miles': miles});
  }

  Future<void> pushAddDoneHike(String hikeName, String hikeType, String mileCount, String longitude, String latitude, String tripDescription, String dateCompleted) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Done Hikes')
        .collection('Hike List')
        .document(hikeName)
        .setData({'Title': hikeName, 'Type': hikeType, "Miles":mileCount, "Description": tripDescription, "Longitude":longitude, "Latitude": latitude, "Date": dateCompleted});
  }
  
  Future<void> deleteHikeFromDonePage(String hikeName) async {
    Firestore.instance
    .collection(globalUserName)
    .document('Done Hikes')
    .collection('Hike List')
    .document(hikeName).delete()
    .catchError( (e) {  print(e);} );
  }

  Future<void> deleteHikeFromToDoPage(String hikeName) async {
    Firestore.instance
    .collection(globalUserName)
    .document('Hikes To Do')
    .collection('Hike List')
    .document(hikeName).delete()
    .catchError( (e) {  print(e);} );
  }

  Future<String> numOfDoneHikes() async {
    String ret = await
    Firestore.instance
    .collection(globalUserName)
    .snapshots()
    .length.toString();

    return ret.toString();
  }

  Future<String> getUserName() async { 
    FirebaseUser mCurrentUser = await FirebaseAuth.instance.currentUser();
    return mCurrentUser.displayName;
  }
  getProfileImage() async {
    FirebaseUser mCurrentUser = await FirebaseAuth.instance.currentUser();
    mCurrentUser.photoUrl;
  }
}
