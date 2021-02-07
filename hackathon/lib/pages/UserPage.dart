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
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('My Bootieqe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              trailing: FlatButton(
                onPressed: null,
                child: Icon(Icons.settings, color: Colors.black,),),
            ),
            Container(
              height: size.height*0.25,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  )
              ),
              child: UserAccountsDrawerHeader(
                accountName: Text(currentUser.uid, style: TextStyle(color: Colors.black),),
                accountEmail: Text(currentUser.email,style: TextStyle(color: Colors.black), ),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://theaeac.org/wp-content/uploads/2016/04/Binghamton-President-Headshot-H.Stenger-e1581548021812.jpg"),
                    radius: size.width*0.2,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Divider(color: Colors.black,),
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
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('장바구니'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact Us'),
            ),
            Divider(
              color: Colors.black,
            ),
            FlatButton(
              color: Colors.white,
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
