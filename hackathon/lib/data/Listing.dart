import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Listing{
  String userId;
  String id;
  String title;
  String category;
  String content;
  int price;
  String image;
  Timestamp createdAt;

  Listing();

  Listing.fromMap(Map<String, dynamic> data){
    userId = data['userId'];
    id = data['id'];
    title = data['title'];
    category = data['category'];
    content = data['content'];
    price = data['price'];
    image = data['image'];

    createdAt = data['createdAt'];
  }

  Map<String, dynamic> toMap(){
    return{
      'userId' : userId,
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