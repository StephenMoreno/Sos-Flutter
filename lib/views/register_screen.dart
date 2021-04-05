import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  String _email, _password,_username;
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);


    final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height / 2,
      width: mq.size.width / 3,
    );



    final emailField = TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.blueAccent),
        decoration: InputDecoration(
          hintText: "something@example.com",
          labelText: "Email",
          hintStyle: TextStyle(color: Colors.blueAccent),
        ),
        onChanged: (value) {
          setState(() {
            _email = value.trim();
          });
        });

    final passwordField = TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.blueAccent),
      decoration: InputDecoration(
        hintText: "password",
        labelText: "password",
        hintStyle: TextStyle(color: Colors.white),
      ),
      onChanged: (value) {
        setState(() {
          _password = value.trim();
        });
      },
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
    final registerButton = Material(
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
          onPressed: () async {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _email.toString(), password: _password.toString());
              Navigator.of(context).pushNamed(AppRoutes.home);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        titlePadding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                        title:
                            Text('The account already exists for that email.'),
                        titleTextStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                      );
                    });
              }
            }
          }),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Already have an account?",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.blueAccent),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
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
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(36, 0, 36, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                logo,
                fields,
                Padding(padding: EdgeInsets.only(top: 20)),
                bottom
              ],
            ),
          )),
    );
  }
}
