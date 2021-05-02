import 'package:flutter/material.dart';

class internetError extends StatefulWidget {
  internetError({Key key}) : super(key: key);

  @override
  _internetErrorState createState() => _internetErrorState();
}

class _internetErrorState extends State<internetError> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Check your internet please"),
      ),
    );
  }
}
