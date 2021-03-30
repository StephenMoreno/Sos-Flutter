import 'package:flutter/material.dart';
import 'package:flutter_app/views/login_screen.dart';
import 'package:flutter_app/views/register_screen.dart';

class AppRoutes{
  AppRoutes._();

  static const String authLogin ='/auth-login';
  static const String authRegister ='/auth-Register';

  static Map<String ,WidgetBuilder> define(){
    return{
      authLogin:(context) => Login(),
      authRegister:(context) => Register(),
    };
  }
}