import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/Services.dart';
import 'package:flutter_app/theme/routes.dart';

// ignore: camel_case_types
class CarsScreen extends StatefulWidget {
  @override
  _CarsScreenState createState() => _CarsScreenState();
}

// ignore: camel_case_types
class _CarsScreenState extends State<CarsScreen> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(fontSize: 17,fontWeight: FontWeight.w500);
    return Scaffold(
      appBar: AppBar(
        title: Text("Morocco - Cars Mechanic",
          style: TextStyle(
            color: Colors.blueAccent,
          ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.blueAccent,),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.home);
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("carsMec").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
                child: CircularProgressIndicator()
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document){
              return Center(
                child: GestureDetector(
                  onTap: (){
                    print(document['name']);

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(image: NetworkImage(document['profileImgUrl']),height: 120,),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 5,left: 10)),
                        Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("" +document['name'],style: cardTextStyle,textAlign: TextAlign.left,),
                                Text("Number :" +document['number'],style: cardTextStyle,),
                                Text("City :" +document['City'],style: cardTextStyle,),
                              ],
                            )
                        )
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
