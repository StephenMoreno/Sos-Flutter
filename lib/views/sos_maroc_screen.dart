import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SosScreen extends StatefulWidget {
  @override
  _SosScreenState createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("sosMaData").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator()
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document){
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/ 1.2,
                  height: MediaQuery.of(context).size.height/ 6,
                  child: Text("Number : "+ document['number']),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
