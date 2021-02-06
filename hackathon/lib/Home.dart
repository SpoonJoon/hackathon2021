import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Listing.dart';
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
  _bottomNavigationBar(){
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[900],
        onTap:_onTap,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('list')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              title: Text('Chat')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('My Account'),
          ),
        ]
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
      body: _children[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
