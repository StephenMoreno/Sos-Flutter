import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/Services.dart';
import 'package:flutter_app/theme/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _imageFile;



  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;

    Future uploadImageToFirebase(BuildContext context) async {
      String fileName = basename(_imageFile.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      taskSnapshot.ref.getDownloadURL().then(
        (value) {
          print("Done: $value");

          CollectionReference users =
              FirebaseFirestore.instance.collection('Users');
          users.doc(uid).update({'imageUrl': value});
          setState(() {});
        },
      );
    }

    Future pickImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = File(pickedFile.path);
        uploadImageToFirebase(context);
      });
    }


    //final uid = user.uid;
    final mq = MediaQuery.of(context);
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String fname, lname, email, imageUrl;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.home);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: SafeArea(
                      child: FutureBuilder(
                          future: users.doc(uid).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data = snapshot.data.data();
                              fname = data['first name'];
                              lname = data['last name'];
                              email = user.email;
                              imageUrl = data['imageUrl'];
                              if(imageUrl == null){
                                imageUrl ="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png";
                              }
                            }
                            return Container(
                              width: mq.size.width * 0.9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Center(
                                      child: GestureDetector(
                                    onTap: () {
                                      print("ok");
                                      pickImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundImage: NetworkImage(imageUrl),
                                    ),
                                  )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: mq.size.height * 0.05)),
                                  TextFormField(
                                    readOnly:true,

                                    decoration: InputDecoration(
                                      hintText: fname,
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: mq.size.height * 0.01)),
                                  TextFormField(
                                    readOnly:true,

                                    decoration: InputDecoration(
                                      hintText: lname,
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: mq.size.height * 0.01)),
                                  TextField(
                                    readOnly:true,

                                    decoration: InputDecoration(
                                      hintText: email,
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top:50)),
                                  Material(

                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Colors.white,

                                    child: MaterialButton(
                                      minWidth: mq.size.width / 1.2,
                                     child:
                                    Text(
                                      "Signout",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pushNamed(AppRoutes.authLogin);

                                    },

                                    ),

                                  )
                                ],
                              ),

                            );
                          })),

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
