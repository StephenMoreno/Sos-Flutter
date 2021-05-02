import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_app/theme/routes.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

CollectionReference users = FirebaseFirestore.instance.collection('Users');
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

getCity() {
  // ignore: non_constant_identifier_names
  String City;
  StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("Users")
        .where('uid', isEqualTo: uid)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      }
      snapshot.data.docs.map((document) {
        City = document['city'];
      });
      return Text(City);
    },
  );
}

Connectivity connectivity = Connectivity();

void getConn() async {
  var connectivityResult = await connectivity.checkConnectivity();
  if (connectivityResult == ConnectivityResult.mobile) {
    print("ok");
  }
}
