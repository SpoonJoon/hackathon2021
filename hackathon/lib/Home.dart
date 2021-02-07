import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Joonie/Desktop/hackathon2021/hackathon/lib/data/Listing.dart';
import 'package:hackathon/pages/ChatPage.dart';
import 'package:hackathon/pages/ListingPage.dart';
import 'package:hackathon/pages/MainPage.dart';
import 'package:hackathon/pages/UserPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex=0;
  final _children = [MainPage(), ListingPage(), ChatPage(), UserPage()];

  //Widgets
  Widget _curvedNavigationBar() {
    return CurvedNavigationBar(
      height: 60,
      backgroundColor: Colors.grey[300],
      buttonBackgroundColor: Colors.transparent,
      color: Colors.green[800],
      items: <Widget>[
        Icon(Icons.home,),
        Icon(Icons.add,),
        Icon(Icons.chat_bubble, ),
        Icon(Icons.person,),
      ],
      onTap: _onTap,
    );
  }
  //functions
  _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _children[_currentIndex],
      bottomNavigationBar: _curvedNavigationBar(),
    );
  }
}
