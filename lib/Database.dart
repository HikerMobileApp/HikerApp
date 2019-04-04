import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Constants.dart';
import 'dart:async';

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

  Future<int> numOfDoneHikes() async{
    final documents = await Firestore.instance.collection(globalUserName)
    .document("Done Hikes").collection("Hike List").getDocuments();
    return documents.documents.length;
  }

  Future<int> numOfTodoHikes() async{
    final documents = await Firestore.instance.collection(globalUserName)
    .document("Hikes To Do").collection("Hike List").getDocuments();
    return documents.documents.length;
  }

  Future<double> milesHiked() async{
      double miles = 0.0;

      var docs = Firestore.instance
        .collection(globalUserName)
        .document("Done Hikes")
        .collection("Hike List")
        //.snapshots()
        .getDocuments();

        //docs.then(onValue)

        //docs.forEach((doc) => miles += double.parse(doc.data()['Miles']));

        return miles;

/*
    Firestore.instance
        .collection(globalUserName)
        .document("Done Hikes")
        .collection("Hike List")
        .snapshots()
        .listen((snapshot) {
           double tempTotal = snapshot.documents.fold(0, (miles, doc) => miles += double.parse(doc.data['Miles']));
           miles = tempTotal;
            print("Miles " + miles.toString());
    });
    */

        

        //docs.forEach((doc) => doc.);
        
        print("Miles " + miles.toString());
      return miles;
}

Future<QuerySnapshot> doneHikes() async{

      var docs = Firestore.instance
        .collection(globalUserName)
        .document("Done Hikes")
        .collection("Hike List")
        .getDocuments();

      return docs;
}

Future<QuerySnapshot> userMarkers() async{
      var docs = Firestore.instance
        .collection(globalUserName)
        .document("Done Hikes")
        .collection("Hike List")
        .getDocuments();

      return docs;
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
