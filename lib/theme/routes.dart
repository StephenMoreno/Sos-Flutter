import 'package:flutter/material.dart';
import 'package:flutter_app/views/ambulance_screen.dart';
import 'package:flutter_app/views/login_screen.dart';
import 'package:flutter_app/views/mechanic_Screen.dart';
import 'package:flutter_app/views/register_screen.dart';
import 'package:flutter_app/views/home.dart';
import 'package:flutter_app/views/profile_Comp.dart';
import 'package:flutter_app/views/F_Password_screen.dart';
import 'package:flutter_app/views/profile_screen.dart';
import 'package:flutter_app/views/sos_maroc_screen.dart';

class AppRoutes{
  AppRoutes._();

  static const String authLogin ='/auth-login';
  static const String authRegister ='/auth-register';
  static const String home ='/home';
  static const String profileComp ='/profileComp';
  static const String forgotPassword ='/forgotPassword';
  static const String profile ='/profile';
  static const String sosMa ='/sosMa';
  static const String ambulance ='/ambulance';
  static const String mechanic ='/mechanic';

  static Map<String ,WidgetBuilder> define(){
    return{
      authLogin:(context) => Login(),
      authRegister:(context) => Register(),
      home:(context)=>Home(),
      profileComp:(context) =>ProfileComp(),
      forgotPassword:(context) =>ForgetPassword(),
      profile:(context) =>ProfileScreen(),
      sosMa:(context) =>SosScreen(),
      ambulance:(context) =>ambulanceScreen(),
      mechanic:(context) =>mechanicScreen(),
    };
  }
}