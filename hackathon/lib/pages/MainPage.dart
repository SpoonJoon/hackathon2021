import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome',
            style: TextStyle(color: Colors.green[900]),
          ),
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
      backgroundColor: Colors.transparent,
        body: Center(child: Container(child: Text('mainpage'),)));
  }
}
