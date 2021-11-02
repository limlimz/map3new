import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DetailsPage.dart';
import 'map.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLoading = true;
  User _user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var doc;


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("user");
    User _user = FirebaseAuth.instance.currentUser;
    _user.uid;
    data();
    setState(() {
      doc;
    });
  }




  Future data() async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print("${documentSnapshot.data()}");
       doc = documentSnapshot.data();
       setState(() {
         doc;
       });
      }
    });
  }



  //  dats() async {
  //
  //    var doc = await data();
  //   print("ggggghggfgfddrrddcfccgcgfcfdfdrdsrddfgchgvhgvgyftxdrxdxfcgvvvhgvgftftrfddrxdx $doc");
  //   return doc;
  // }

  @override
  Widget build(BuildContext context) {

    // return isLoading ? Scaffold(
    //   body: Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // ): doc == null ? Detail() :
    //
    //     Map();
  setState(() {
    doc;
  });
    print(doc);

    if (doc != null)
    {
      print ( "limmmmmffdf $doc");
      return Mapservice();
    }
else
  {
    return Detail();
  }
  }
}
