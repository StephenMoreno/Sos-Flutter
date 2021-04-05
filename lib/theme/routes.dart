import 'package:flutter/material.dart';
import 'package:flutter_app/views/login_screen.dart';
import 'package:flutter_app/views/register_screen.dart';
import 'package:flutter_app/views/home.dart';

class AppRoutes{
  AppRoutes._();

  static const String authLogin ='/auth-login';
  static const String authRegister ='/auth-register';
  static const String home ='/home';

  static Map<String ,WidgetBuilder> define(){
    return{
      authLogin:(context) => Login(),
      authRegister:(context) => Register(),
      home:(context) =>Home(),
    };
  }
}