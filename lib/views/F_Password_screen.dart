import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ForgetPassword extends StatefulWidget{

  @override _ForgetPasswordViewState createState() =>_ForgetPasswordViewState();

}

class _ForgetPasswordViewState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;

  String _email;

  bool isSubmitting = false;

  @override
  Widget build(BuildContext context){
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height / 2,
    );

    final emailField = TextFormField(

      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.blueAccent
      ),
      decoration: InputDecoration(
        hintText: "something@example.com",
        labelText: "Email",
        hintStyle: TextStyle(
          color: Colors.blueAccent
        ),
      ),onChanged: (value) {
          setState(() {
            _email = value.trim();
         });
        },
    );



    final fields = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
        ],
      ),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Forgot Password",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          final auth = FirebaseAuth.instance;
          auth.sendPasswordResetEmail(email: _email);
          showDialog(context: context,
              builder: (BuildContext context){
                return SimpleDialog(
                  titlePadding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                  title:
                  Text('We have sent a link to recover your password, please check your email.'),
                  titleTextStyle:
                  TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                );
              });
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        }

      ),
    );


    return Scaffold(
      body: Form(
        key: _formKey,
        child:SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              logo,
              fields,
              Padding(padding: EdgeInsets.fromLTRB(0,20,0,20)),
              loginButton

            ],
          ),
        )

      ),
    );

  }
}