
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_verification/model/user.dart';
import 'package:phone_verification/screens/DetailsPage.dart';
import 'package:phone_verification/screens/map.dart';

class Database {
  Future  data() async {

    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {

      return documentSnapshot.data();

      if (documentSnapshot.exists) {
        return  Map();
      } else {
        return Detail();
      }
    });
  }
  Future<UserModel> getuserprofile() {
    print("user id "+FirebaseAuth.instance.currentUser.uid.toString());
    return FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {

      var limz = value.data();
      print("data " + limz.toString());

      return UserModel.fromJson(limz);
    });
  }










}
