import 'package:flutter/material.dart';

class Offer{
  String sender;
  String receiver;
  String title;
  String image;
  String price;

  Offer();

  Offer.fromMap(Map<String, dynamic> data){
    sender = data['sender'];
    receiver = data['receiver'];
    title = data['title'];
    image = data['image'];
    price = data['price'];
  }

  Map<String, dynamic> toMap(){
    return{
      'sender' : sender,
      'receiver' : receiver,
      'title' : title,
      'image' : image,
      'price' : price,
    };
  }
}
