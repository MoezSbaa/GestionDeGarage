import 'package:flutter/material.dart';
class welcome extends StatefulWidget {

  String username;
  welcome({this.username});

  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hi mr user : ${widget.username}"),
      ),
    );
  }
}
