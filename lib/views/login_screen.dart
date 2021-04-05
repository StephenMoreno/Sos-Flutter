import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget{

  @override _LoginViewState createState() =>_LoginViewState();

}

class _LoginViewState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _passwordController;

  String _email, _password;

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

    final passwordField = Column(
      children: <Widget>[
      TextFormField(

      controller: _passwordController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          color: Colors.blueAccent
      ),
      decoration: InputDecoration(
        hintText: "password",
        labelText: "password",
        hintStyle: TextStyle(
            color: Colors.white
        ),
      ),
        onChanged: (value) {
          setState(() {
            _password = value.trim();
          });
        },

    ),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              child: Text(
                "Forgot password",
                style: Theme.of(context).textTheme.caption.copyWith(color: Colors.blueAccent),
              ),
              onPressed: (){
                //Ford
              },
            ),
          ],
        )
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
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
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          try {
            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: _email.toString(),
                password: _password.toString()
            );
            Navigator.of(context).pushNamed(AppRoutes.home);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
                 showDialog(context: context,
                     builder: (BuildContext context){
                   return SimpleDialog(
                     titlePadding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                     title:
                     Text('User not found, Please check the email.'),
                     titleTextStyle:
                     TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                   );
                     });
            } else if (e.code == 'wrong-password') {
               showDialog(context: context, builder: (BuildContext context){
                 return SimpleDialog(
                   titlePadding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                   title:
                   Text('Wrong password provided for that user.'),
                   titleTextStyle:
                   TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                 );
               });
            }
          }
        }

      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Not a member?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.blueAccent),
            ),
            MaterialButton(
              onPressed:(){ Navigator.of(context).pushNamed(AppRoutes.authRegister);},
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        )

      ],
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
              bottom
            ],
          ),
        )

      ),
    );

  }
}