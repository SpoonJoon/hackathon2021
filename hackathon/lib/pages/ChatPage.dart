
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/data/Offer.dart';

class ChatPage extends StatelessWidget {

  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'Offers',
          style: TextStyle(color: Colors.green[900]),
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Offers').where('receiver', isEqualTo: currentUser.uid).snapshots(),
        builder: (context, snapShot){

          if(!snapShot.hasData){
            return CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapShot.data.documents.length,
              itemBuilder: (context, index){
                DocumentSnapshot documentSnapshot = snapShot.data.documents[index];
                Offer offer = Offer.fromMap(documentSnapshot.data());
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    leading: Image.network(offer.image),
                    title: Text(offer.sender),
                    trailing: Text("\$" + offer.price),
                  ),
                );});
        },
      ),
    );
  }
}
