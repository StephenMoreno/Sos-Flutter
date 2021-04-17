import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/routes.dart';



class ProfileComp extends StatefulWidget {

  @override
  _ProfileCompState createState() => _ProfileCompState();
}

class _ProfileCompState extends State<ProfileComp> {
  final _formKey = GlobalKey<FormState>();

  String _firstName, _lastName,_chosenValue;
  DateTime _dateOfBirth;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    DateTime _dateTime = DateTime.now();

    final firstNameField = TextFormField(
      style: TextStyle(
          color: Colors.blueAccent
      ),
      decoration: InputDecoration(
        hintText: "Jhon",
        labelText: "First Name",
        hintStyle: TextStyle(
            color: Colors.blueAccent
        ),
      ),onChanged: (value) {
      setState(() {
        _firstName = value.trim();
      });
    },
    );

    final lastNameField = TextFormField(
      style: TextStyle(
          color: Colors.blueAccent
      ),
      decoration: InputDecoration(
        hintText: "Doe",
        labelText: "Last Name",
        hintStyle: TextStyle(
            color: Colors.blueAccent
        ),
      ),onChanged: (value) {
      setState(() {
        _lastName = value.trim();
      });
    },
    );

    final dateOfBirth = SizedBox(
        height: 100,
        child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged:(date){
              setState(() {
                _dateOfBirth=date;
              });
            })
    );

    final fields = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          firstNameField,
          lastNameField,
        ],
      ),
    );

    final textDteOfBirth = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "Date Of Birth",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
        )
      ],
    );

    final textWelcom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "One more step to complete the registration",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold),
        )
      ],
    );

    final nextButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
          minWidth: mq.size.width / 1.2,
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: Text(
            "Next",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async{
            print("okok");
            CollectionReference users = FirebaseFirestore.instance.collection('Users');
            FirebaseAuth auth = FirebaseAuth.instance;
            String uid = auth.currentUser.uid.toString();
            users.doc(uid).set({
              'first name':_firstName,
              'last name' :_lastName,
              'date of birth':_dateOfBirth,

            });
            User user = FirebaseAuth.instance.currentUser;
            if (!user.emailVerified) {
              await user.sendEmailVerification();
            }
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
            Navigator.of(context).pushNamed(AppRoutes.home);

          }),
    );

    final acceptText = Column(
      children: <Widget>[
        Text(
          "By clicking next you are ept ",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.blueAccent),
        ),
        MaterialButton(
          onPressed: () {

          },
          child: Text(
            "our policies",
            style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
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
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,20)),
                textWelcom,
                fields,
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,20)),
                textDteOfBirth,
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,20)),
                dateOfBirth,
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,0)),
                nextButton,
                Padding(padding: EdgeInsets.fromLTRB(0,20,0,20)),
                acceptText
              ],
            ),
          )

      ),
    );
  }
}