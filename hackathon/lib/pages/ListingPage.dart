import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../Listing.dart';

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
  File _imageFile;
  DocumentReference listingRef = FirebaseFirestore.instance.collection("Listing").doc();


  //functions

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future takeImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create a Listing',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white30,
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
            autovalidate: true,
            child: Column(children: <Widget>[
              Divider(),
              Padding(
                padding: EdgeInsets.only(right: 18, left: 18),
                child: TextFormField(
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      focusColor: Colors.black,
                      hintText: 'Title',
                      hintStyle: TextStyle(fontSize: 18),
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
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: Colors.grey,
                      ),
                      hintText: "Set Price",
                      hintStyle: TextStyle(fontSize: 18),
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
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 18),
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
              ),
              Divider(),
              Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Container(
                    height: size.height * 0.06,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Category',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
              Divider(),
            ]),
          ),
        ));
  }
}
