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
  var doc;

  User _user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("user");
    User _user = FirebaseAuth.instance.currentUser;
    _user.uid;
    data();
    dats();
    doc =data();
    doc;
  }

  Future data() async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser.uid.toString())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print("${documentSnapshot.data()}");
        return documentSnapshot.data();
      }
    });
  }

  void dats() async {
    doc = await data();
    print("ggggghggfgfddrrddcfccgcgfcfdfdrdsrddfgchgvhgvgyftxdrxdxfcgvvvhgvgftftrfddrxdx $doc");
  }

  @override
  Widget build(BuildContext context) {
    if (doc == null) {
      print ("hgyrddrtddrtrtddrrttr$doc");
      return Detail();
    }
    if (doc != null)
    {
      print (doc);
      return Map();
    }
  }
}
