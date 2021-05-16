import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/Services.dart';
import 'package:flutter_app/theme/routes.dart';

class MechanicsScreen extends StatefulWidget {
  MechanicsScreen({Key key}) : super(key: key);

  @override
  _MechanicsScreenState createState() => _MechanicsScreenState();
}

class _MechanicsScreenState extends State<MechanicsScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.home);
                        },
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        primary: false,
                        crossAxisCount: 3,
                        children: <Widget>[
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.cars);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(bottom: 5)),
                                  Text(
                                    "CARS",
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),


                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.bikes);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(bottom: 5)),
                                  Text(
                                    "BIKES",
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),



                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
