import 'package:flutter/material.dart';
import 'package:flutter_app/views/login_screen.dart';
import 'package:flutter_app/views/register_screen.dart';
import 'package:flutter_app/views/home.dart';
import 'package:flutter_app/views/profile_Comp.dart';
import 'package:flutter_app/views/F_Password_screen.dart';

class AppRoutes{
  AppRoutes._();

  static const String authLogin ='/auth-login';
  static const String authRegister ='/auth-register';
  static const String home ='/home';
  static const String profileComp ='/profileComp';
  static const String forgotPassword ='/forgotPassword';

  static Map<String ,WidgetBuilder> define(){
    return{
      authLogin:(context) => Login(),
      authRegister:(context) => Register(),
      home:(context)=>Home(),
      profileComp:(context) =>ProfileComp(),
      forgotPassword:(context) =>ForgetPassword(),

    };
  }
}