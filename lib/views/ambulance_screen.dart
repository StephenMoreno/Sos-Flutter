import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/theme/routes.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class ambulanceScreen extends StatefulWidget {
  @override
  _ambulanceScreenState createState() => _ambulanceScreenState();
}

// ignore: camel_case_types
class _ambulanceScreenState extends State<ambulanceScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w500);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Morocco - Ambulance",
          style: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.home);
          },
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("ambulanceData").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    print(document['name']);
                    String number = document['number'];
                    _launchCaller() async {
                      if (await canLaunch(number)) {
                        await launch(number);
                      } else {
                        throw 'Could not launch $number';
                      }
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image(
                            image: NetworkImage(document['logoUrl']),
                            height: 120),
                        Padding(padding: EdgeInsets.only(bottom: 5, left: 10)),
                        Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "" + document['name'],
                                  style: cardTextStyle,
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Number :" + document['number'],
                                  style: cardTextStyle,
                                ),
                                Text(
                                  "City :" + document['City'],
                                  style: cardTextStyle,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
