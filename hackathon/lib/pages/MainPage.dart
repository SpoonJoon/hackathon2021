

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackathon/data/Listing.dart';
import 'package:hackathon/data/Offer.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String selected = 'Textbooks';

  Widget scrollSelect(Size size){
    return Container(
    height: size.height*0.05,
    child: Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(width: size.width*0.1,),
          GestureDetector(
            child: Container(
              height: size.height*0.01,
              width: size.width*0.32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected=='Textbooks'? Colors.white: Colors.green[900],
                //border: Border.all(color: Colors.green[900])
              ),
              child: Center(child: Text('Textbooks', style: TextStyle(color: selected=='Textbooks'? Colors.green[900]: Colors.white),)),
            ),
            onTap: (){
              setState(() {
                selected = 'Textbooks';
              });
            },
          ),
          Container(width: size.width*0.05,),
          GestureDetector(
            child: Container(
              height: size.height*0.01,
              width: size.width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == 'Furniture'?Colors.white :Colors.green[900],
                //border: Border.all(color: Colors.green[900])
              ),
              child: Center(child: Text('Furniture', style: TextStyle(color: selected == 'Furniture'? Colors.green[900]: Colors.white),)),
            ),
            onTap: (){
              setState(() {
                selected = 'Furniture';
              });
            },
          ),
          Container(width: size.width*0.05,),
          GestureDetector(
            child: Container(
              height: size.height*0.01,
              width: size.width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == 'Electronics'? Colors.white :Colors.green[900],
                //border: Border.all(color: Colors.green[900])
              ),
              child: Center(child: Text('Electronics', style: TextStyle(color: selected == 'Electronics'? Colors.green[900]:Colors.white),)),
            ),
            onTap: (){
              setState(() {
                selected = 'Electronics';
              });
            },
          ),
          Container(width: size.width*0.05,),
          GestureDetector(
            child: Container(
              height: size.height*0.01,
              width: size.width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == 'Appliances'? Colors.white :Colors.green[900],
                //border: Border.all(color: Colors.green[900])
              ),
              child: Center(child: Text('Appliances', style: TextStyle(color: selected == 'Appliances'? Colors.green[900]:Colors.white),)),
            ),
            onTap: (){
              setState(() {
                selected = 'Appliances';
              });
            },
          ),
          Container(width: size.width*0.05,),
          GestureDetector(
            child: Container(
              height: size.height*0.01,
              width: size.width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == 'Clothing'? Colors.white :Colors.green[900],
                //border: Border.all(color: Colors.green[900])
              ),
              child: Center(child: Text('Clothing', style: TextStyle(color: selected == 'Clothing'? Colors.green[900]:Colors.white),)),
            ),
            onTap: (){
              setState(() {
                selected = 'Clothing';
              });
            },
          )
        ],
      ),
    ),
  );}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome',
            style: TextStyle(color: Colors.green[900]),
          ),
          backgroundColor: Colors.grey[300],
          elevation: 0,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.search, color: Colors.green[900],))
          ],
        ),
      backgroundColor: Colors.transparent,
        body: Column(
          children:<Widget>[
            Container(height: size.height*0.01,),
            scrollSelect(size),
            Container(
              height: size.height*0.75,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Listing').where('category', isEqualTo: selected).snapshots(),
                builder: (context, snapShot){
                  if(!snapShot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else{
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: GridView.builder(
                        itemCount: snapShot.data.documents.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
                        itemBuilder: (context, index){
                          DocumentSnapshot documentSnapshot = snapShot.data.documents[index];
                          Listing listing = Listing.fromMap(documentSnapshot.data());
                          return Hero(
                            tag: listing.id,
                            child: GestureDetector(
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(children: [
                                      Container(
                                          height: 150,
                                          width: 150,
                                          child: Image.network(listing.image.toString(), fit: BoxFit.fitWidth, )
                                      ),
                                      Container(height: 4,),
                                      Row(
                                        children: <Widget>[
                                          Container(width: 25,),
                                          Expanded(child: Text(listing.title.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),),
                                          Container(width: 25,),
                                          Container(
                                            width: 46,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[400],
                                                  borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(child: Text( '\$' + listing.price.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)))
                                          ,Container(width: 20,),
                                        ]
                                      ),
                                    ])),
                              ),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HeroPage(listing)));
                              },
                            ),
                          );
                        }),
                    );}
                }),
            ),

          ]
        )
    );
  }
}

class HeroPage extends StatelessWidget {
  TextEditingController _priceController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Offer _offer = Offer();

  uploadToFirebase(Offer offer) async{
    CollectionReference ref = FirebaseFirestore.instance.collection('Offers');
    DocumentReference documentReference = await ref.add(offer.toMap());
  }

  Listing listing;
  HeroPage(this.listing);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton( icon: Icon(Icons.chevron_left), color:Colors.green[900],onPressed: ()=>Navigator.of(context).pop(),),
        title: Text(
          listing.title,
          style: TextStyle(color: Colors.green[900],),
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Hero(
        tag: listing.id,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  height: size.height*0.6,
                  child: Image.network(listing.image,)),
              Container(
                width: size.width,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                             color: Colors.grey[400],
                             borderRadius: BorderRadius.circular(10),
                          ),
                            child: Center(child: Text( "\$" + listing.price.toString(), style: TextStyle(fontSize: 18),))),
                          Container(width: 10,),
                          Text(listing.category, style: TextStyle(fontSize: 14, color: Colors.grey))
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        width: size.width,
                        height: 90,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(listing.content, style: TextStyle(fontSize: 18),)),
                        ),
                      ),
                      Container(height: 5,),
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.only( right: 18),
                              child: TextFormField(
                                key: _formKey,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                    suffixIcon: FlatButton(
                                      child: Text('Make Offer'),
                                      onPressed: (){

                                          _offer.sender = currentUser.email;
                                          _offer.receiver = listing.userId;
                                          _offer.price = _priceController.text;
                                          _offer.title = listing.title;
                                          _offer.image = listing.image;

                                          uploadToFirebase(_offer);
                                          print('success');

                                          Navigator.of(context).pop();

                                      },
                                    ),
                                    prefixIcon: Icon(
                                      Icons.attach_money,
                                      color: Colors.black,
                                    ),
                                    hintText: "Offer Price",
                                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                                controller: _priceController,
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return 'Please Enter Price';
                                  return null;
                                },
                              ),
                            ),
                          )
                        ])),
              )
            ],
          ),
        ),
      )
    );
  }
}

