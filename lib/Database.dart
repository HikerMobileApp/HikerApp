import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Constants.dart';
import 'dart:async';

class Database {
  Future<void> pushAddHike(
      String hikeName, String hikeType, String miles) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Hikes To Do')
        .collection('Hike List')
        .document(hikeName)
        .setData({'Title': hikeName, 'Type': hikeType, 'Miles': miles});
  }

  Future<void> pushAddDoneHike(
      String hikeName,
      String hikeType,
      String mileCount,
      String longitude,
      String latitude,
      String tripDescription,
      String dateCompleted) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Done Hikes')
        .collection('Hike List')
        .document(hikeName)
        .setData({
      'Title': hikeName,
      'Type': hikeType,
      "Miles": mileCount,
      "Description": tripDescription,
      "Longitude": longitude,
      "Latitude": latitude,
      "Date": dateCompleted
    });
  }

   Future<void> pushImageOne(String url, String hikeName) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Done Hikes')
        .collection('Hike List')
        .document(hikeName)
        .updateData({
        "url1": url
    });
  }
    Future<void> pushImageTwo(String url, String hikeName) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Done Hikes')
        .collection('Hike List')
        .document(hikeName)
        .updateData({
        "url2": url
    });
  }
      Future<void> pushImageThree(String url, String hikeName) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Done Hikes')
        .collection('Hike List')
        .document(hikeName)
        .updateData({
        "url3": url
    });
  }
  

  Future<void> deleteHikeFromDonePage(String hikeName) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Done Hikes')
        .collection('Hike List')
        .document(hikeName)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  Future<void> deleteHikeFromToDoPage(String hikeName) async {
    Firestore.instance
        .collection(globalUserName)
        .document('Hikes To Do')
        .collection('Hike List')
        .document(hikeName)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  Future<int> numOfDoneHikes() async {
    final documents = await Firestore.instance
        .collection(globalUserName)
        .document("Done Hikes")
        .collection("Hike List")
        .getDocuments();
    return documents.documents.length;
  }

  Future<int> numOfTodoHikes() async {
    final documents = await Firestore.instance
        .collection(globalUserName)
        .document("Hikes To Do")
        .collection("Hike List")
        .getDocuments();
    return documents.documents.length;
  }

  Future<double> milesHiked() async {
    double miles = 0.0;

    var _ = Firestore.instance
        .collection(globalUserName)
        .document("Done Hikes")
        .collection("Hike List")
        .getDocuments();

    return miles;
  }

  Future<QuerySnapshot> doneHikes() async {
    var docs = Firestore.instance
        .collection(globalUserName)
        .document("Done Hikes")
        .collection("Hike List")
        .getDocuments();

    return docs;
  }

  Future<QuerySnapshot> userMarkers() async {
    var docs = Firestore.instance
        .collection(globalUserName)
        .document("Done Hikes")
        .collection("Hike List")
        .getDocuments();

    return docs;
  }

  Future<QuerySnapshot> otherUserMarkers(String otherUserName) async {
    var docs = Firestore.instance
        .collection(otherUserName)
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

  Future<void> addUsername(String username) async {
    print("-------------------------ADD USER------------------------");
    Firestore.instance
        .collection("USERS")
        .document(username)
        .setData({'Name': username});
  }

    Future<void> addMilesHiked(String username, double miles) async {
    print("-------------------------ADD Miles Hiked------------------------");
    Firestore.instance
        .collection("USERS")
        .document(username).updateData({'MilesHiked': miles.toStringAsFixed(2)});
        //.setData({'Name': username,'MilesHiked': miles});
  }

    Future<void> addImage(String username, String image) async {
    print("-------------------------ADD Image------------------------");
    Firestore.instance
        .collection("USERS")
        .document(username).updateData({'profilePic': image});
        //.setData({'Name': username,'MilesHiked': miles});
  }

    Future<void> addFollower(String username) async {
    print("-------------------------ADD Follower------------------------");
    Firestore.instance
        .collection(globalUserName)
        .document("Following")
        .updateData({'Following': FieldValue.arrayUnion([username])});
  }


  Future<void> unFollow(String username) async {
    print("-------------------------Delete Follower------------------------");
    Firestore.instance
        .collection(globalUserName)
        .document("Following")
        .updateData({'Following': FieldValue.arrayRemove([username])});
  }



}
