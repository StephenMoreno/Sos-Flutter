import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/Services.dart';
import 'package:flutter_app/views/home.dart';
import 'package:flutter_app/views/opening_screen.dart';
import 'package:flutter_app/theme/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getConn();
    return MaterialApp(
      title: 'Flutter Demo',
      routes: AppRoutes.define(),
      home: Home(),
    );
  }
}
