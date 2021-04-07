import 'package:firebase_auth/firebase_auth.dart';
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
    return Container(color: const Color(0xFFFFE306));

  }
}