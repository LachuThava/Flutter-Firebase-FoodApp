import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_app/Entity/Food.dart';
import 'package:my_app/main.dart';

import 'dart:collection';

import 'package:my_app/pages/MyCart.dart';

void signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pop();
}

//variables declare
int i = 0;
int key = 0;
List<Food> list = [];

class foodDetails extends StatefulWidget {
  final String image;
  final String name;
  final String rating;
  final String price;
  const foodDetails(this.image, this.name, this.rating, this.price);

  @override
  _foodDetailsState createState() => _foodDetailsState();
}

class _foodDetailsState extends State<foodDetails> {
  String? get image => widget.image;

  String? get name => widget.name;

  String? get price => widget.price;

  String? get rating => widget.rating;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
            child: Container(
      width: w,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // back button
            Container(
              alignment: Alignment.bottomLeft,
              width: w,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
                alignment: Alignment.centerRight,
              ),
            ),
            // photo
            Center(
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Container(
                  // margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: w * 0.9,
                  height: h * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            // Heading Food Name
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                widget.name,
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu'),
              ),
            ),
            // description
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sea deserunt mollit anim id est laborum",
                style: TextStyle(fontSize: 30),
              ),
            ),
            // price
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Price: Rs. " + widget.price + "/=",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            // rating
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Rating : " + widget.rating + "/5",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            // number of count
            Center(
              child: Container(
                // color: Colors.brown,
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (i > 0) {
                              i--;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.remove,
                          size: 30,
                        ),
                      ),
                    ),
                    Text(
                      "$i",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            i++;
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              // margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              // decoration: BoxDecoration(color: Colors.lightGreen),
              width: w,
              height: h * 0.1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  Food food =
                      new Food(key, widget.name, int.parse(widget.price), i);
                  list.add(food);
                  new MyCard(list);

                  Navigator.of(context).pop();
                  setState(() {
                    i = 0;
                  });
                },
                child: Text(
                  'AddCart',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
