import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../data/Listing.dart';

class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  Listing _currentListing;
  final picker = ImagePicker();
  String category = 'Category';
  File _imageFile;
  bool imageExists = false;
  DocumentReference listingRef = FirebaseFirestore.instance.collection("Listing").doc();


  //widgets
  Widget _title(){
    return Padding(
      padding: EdgeInsets.only(right: 18, left: 18),
      child: TextFormField(
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            focusColor: Colors.black,
            hintText: 'Title',
            hintStyle: TextStyle(fontSize: 18, color: Colors.black),
            border: InputBorder.none),
        controller: _titleController,
        validator: (String value) {
          if (value.isEmpty)
            return 'Title is required';
          return null;
        },
        onSaved: (String value){
          _currentListing.title = value;
        },
      ),
    );
  }

  Widget _category(){
    return DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left:20, right: 20)
        ),
        value: category,
        items: <String>['Category', 'Text Book', 'Clothes', 'Appliances']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: Colors.black, fontSize: 18,),),
          );
        }).toList(),
        onChanged: (str) {
            setState(() {
              category = str;
            });
      }
    );
  }

  Widget _description(){
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 5,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            hintText: 'Description',
            hintStyle: TextStyle(fontSize: 18, color: Colors.black),
            border: InputBorder.none,
            focusedBorder: InputBorder.none),
        controller: _contentController,
        validator: (String value) {
          if (value.isEmpty)
            return 'Please Enter Description';
          return null;
        },
        onSaved: (String value){
          _currentListing.content = value;
        },
      ),
    );
  }

  Widget _selectImages(Size size){
    return Container(
      height: size.height*0.22,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width*0.03, right: size.width*0.03, ),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: imageExists? Image.file(_imageFile) : GestureDetector(
            onTap: pickImage,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[Icon(Icons.photo_library, size: 30), Container(height: 3,),Text('Upload Image')] ),
          ),
        ),
      ),
    );
  }

  Widget _price(Size size){
    return Container(
      height: size.height*0.12,
      width: size.width,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width*0.03, right: size.width*0.03, ),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Colors.black,
                    ),
                    hintText: "Price",
                    hintStyle: TextStyle(fontSize: 18, color: Colors.black),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none),
                controller: _priceController,
                validator: (String value) {
                  if (value.isEmpty)
                    return 'Please Enter Price';
                  return null;
                },
                onSaved: (String value){
                  _currentListing.price = double.parse(value);
                },
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget _itemInfo(Size size){
    return Container(
      height: size.height*0.4,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width*0.03, right: size.width*0.03, ),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
                children: <Widget>[
                  _title(),
                  Divider(
                    height: 3,
                    color: Colors.grey,
                    thickness: 0.55,
                  ),
                  _category(),
                  _description(),
                ],
              )
          )
        ),
    );
  }

  //functions
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
      imageExists = true;
    });
  }

  Future takeImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(pickedFile.path);
      imageExists = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'New Listing',
            style: TextStyle(color: Colors.green[900]),
          ),
          backgroundColor: Colors.grey[300],
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_right),
              color: Colors.black,
              onPressed: () {
                //saveImages(_imageFileList, listingRef);
                //_uploadListing(_currentListing);
                //Navigator.push(context, SlideLeftRoute(page: AddLabel(_imageFileList)));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            //autovalidate: true,
            child: Column(children: <Widget>[
              _selectImages(size),
              _price(size),
              _itemInfo(size),
            ]),
          ),
        ));
  }
}
