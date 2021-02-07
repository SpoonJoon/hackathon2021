import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {

  final currentUser = FirebaseAuth.instance.currentUser;

  _logout() async{
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[900]),),
              trailing: FlatButton(
                onPressed: null,
                child: Icon(Icons.settings, color: Colors.green[900],),),
            ),

            Container(
              height: size.height*0.25,
              child: UserAccountsDrawerHeader(
                accountName: Text('Joonhwan Yoo', style: TextStyle(color: Colors.black),),
                accountEmail: Text(currentUser.email,style: TextStyle(color: Colors.black), ),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/joon.jpg"),
                    radius: size.width*0.4,
                  ),
                ),
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            ),
            Divider(color: Colors.black,height: 0,),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Sold Items'),
            ),
            ListTile(
              leading: Icon(Icons.featured_play_list),
              title: Text('Listed Items'),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Liked Items'),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Shopping Cart'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact Us'),
            ),
            Divider(
              color: Colors.black,
            ),
            FlatButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              child: ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
