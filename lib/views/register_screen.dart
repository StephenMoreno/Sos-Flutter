import 'package:flutter/material.dart';
import 'package:flutter_app/theme/routes.dart';

class Register extends StatefulWidget{
  @override _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<Register>{
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _repasswordController;
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context){
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height / 2,
      width: mq.size.width/3,
    );

    final usernameField = TextFormField(
      controller: _usernameController,
      style: TextStyle(
          color: Colors.blueAccent
      ),
      decoration: InputDecoration(
        hintText: "Jhon Doe",
        labelText: "username",
        hintStyle: TextStyle(
            color: Colors.blueAccent
        ),
      ),
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
      ),
    );

    final passwordField = TextFormField(
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

    );

    final repasswordField = TextFormField(
      controller: _repasswordController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          color: Colors.blueAccent
      ),
      decoration: InputDecoration(
        hintText: "repassword",
        labelText: "repassword",
        hintStyle: TextStyle(
            color: Colors.white
        ),
      ),

    );

    final fields = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          usernameField,
          emailField,
          passwordField,
          repasswordField
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
            "Register",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {

          }
        // TODO: AlertDialog with error


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
              "Already have an account?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.blueAccent),
            ),
            MaterialButton(
              onPressed:(){ Navigator.of(context).pushNamed(AppRoutes.authLogin);},
              child: Text(
                "Login",
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
            padding: EdgeInsets.fromLTRB(36, 0, 36, 30),
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
