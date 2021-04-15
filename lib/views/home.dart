import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/routes.dart';


class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.of(context).pushNamed(AppRoutes.authLogin);
      } else {
        User user = FirebaseAuth.instance.currentUser;
        if (!user.emailVerified) {
        }
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    String firstN;
    String lastN;

    var size = MediaQuery.of(context).size;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    var cardTextStyle = TextStyle(fontSize: 17,fontWeight: FontWeight.w500);


    return Scaffold(
     body: Stack(
       children: <Widget>[
         Container(
           height: size.height,
           decoration: BoxDecoration(
             image: DecorationImage(
               alignment: Alignment.topCenter,
               image: AssetImage("assets/top_header.png")
             )
           ),
         ),
         SafeArea(child:Padding(
           padding: EdgeInsets.all(16),
           child:  Column(
             children: <Widget>[
               Container(
                 height: 64,
                 margin: EdgeInsets.only(bottom: 20),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     CircleAvatar(
                       radius: 32,
                       backgroundImage: AssetImage('assets/user_icon.png'),
                       backgroundColor: Colors.transparent,child: GestureDetector(onTap: (){
                         Navigator.of(context).pushNamed(AppRoutes.profile);
                     },),

                     ),
                     SizedBox(width: 16,),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(padding: EdgeInsets.all(10),),
                         FutureBuilder<DocumentSnapshot>(
                           future: users.doc(uid).get(),
                           builder:
                               (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                             if (snapshot.hasError) {
                               return Text("Something went wrong");
                             }

                             if (snapshot.connectionState == ConnectionState.done) {
                               Map<String, dynamic> data = snapshot.data.data();
                               return Text("${data['first name']} ${data['last name']}",style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 18,
                                 color: Colors.white
                               ),);
                             }

                             return Text("loading");
                           },
                         ),
                       ],
                     )
                   ],
                 ),
               ),
              Expanded(
                child:GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: InkWell(
                        onTap: (){

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("assets/doc_logo.png"),height: 120,),
                            Padding(padding: EdgeInsets.only(bottom: 5)),
                            Text("Doctors",style: cardTextStyle,)
                          ],
                        ),

                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: InkWell(
                        onTap: (){

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("assets/car_mechanic_logo.png"),height: 120,),
                            Padding(padding: EdgeInsets.only(bottom: 5)),
                            Text("Mechanic",style: cardTextStyle,)
                          ],
                        ),

                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: InkWell(
                        onTap: (){

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("assets/ambulance_logo.png"),height: 120,),
                            Padding(padding: EdgeInsets.only(bottom: 5)),
                            Text("Ambulance",style: cardTextStyle,)
                          ],
                        ),

                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(AppRoutes.sosMa);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage("assets/Sos_logo.png"),height: 120,),
                            Padding(padding: EdgeInsets.only(bottom: 5)),
                            Text("SOS MAROC",style: cardTextStyle,)
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
              )
             ],
           ),
         )
        )
       ],
     ),

   );
  }
}