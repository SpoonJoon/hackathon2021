import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Listing{
  String id;
  String title;
  String category;
  String content;
  double price;
  String image;
  Timestamp createdAt;

  Listing();

  Listing.fromMap(Map<String, dynamic> data){
    id = data['id'];
    title = data['name'];
    category = data['category'];
    content = data['content'];
    price = data['price'];
    image = data['image'];

    createdAt = data['createdAt'];
  }

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'title' : title,
      'category' : category,
      'content' : content,
      'price' : price,
      'image' : image,
      'createdAt' : createdAt,
    };
  }
}