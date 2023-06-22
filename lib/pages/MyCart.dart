import 'dart:collection';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_app/Entity/Food.dart';
import 'package:my_app/Foods/FoodDetails.dart' as FoodDetails;
import 'package:my_app/pages/SignUp.dart';

int j = 0;

class MyCard extends StatefulWidget {
  List<Food> foods = FoodDetails.list;
  MyCard(this.foods);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  List<Food> foods = FoodDetails.list;
  bool dialogMsg = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> payNow(List<Food> foods) async {
    print("paying");
    List<Map> array = [];
    CollectionReference db = FirebaseFirestore.instance.collection("Payments");
    double total = 0;
    if (foods == null) {
      print("empty foods");
    } else {
      for (Food food in foods) {
        total += food.getQuantity() * food.getPrice();
        final data = {
          "name": food.getFoodName(),
          "quantity": food.getQuantity(),
          "price": food.getPrice()
        };
        array.add(data);
      }
      final bigData = {"Items": array, "totalPrice": total};
      await db
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(DateTime.now().toString())
          .add(bigData)
          .then((documentSnapshot) => {print(documentSnapshot)});

      setState(() {
        this.foods = [];
        this.dialogMsg = true;
      });
    }

    FoodDetails.list = [];
    // await db.add(bigData).then((documentSnapshot) => {print(documentSnapshot)});
  }

  showAlertDialog(BuildContext context) {
    print("dialog");
    return AlertDialog(
      title: Text(
        "Successfully Paid",
        style: TextStyle(color: Colors.green[600]),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text("ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Image(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            image: NetworkImage(
              "https://cdn.dribbble.com/users/2046015/screenshots/5973727/media/a603779536f0491b4be24ba2d03903e1.gif",
            ),
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: w,
            height: h * 0.08,
            decoration: BoxDecoration(color: Colors.white),
            child: Text(
              'My Cart',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: w,
            height: h * 0.35,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: itemList(foods),
              ),
            ),
          ),
          Container(
            width: w,
            height: h * 0.1,
            decoration: BoxDecoration(),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: Text(
                'PayNow',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                payNow(this.foods);
                // showAlertDialog(context);
                // showDialog(
                //     context: context,
                //     builder: (BuildContext buildContext) => AlertDialog(
                //           title: Text(
                //             "Successfully Paid",
                //             style: TextStyle(color: Colors.green[600]),
                //           ),
                //           actions: <Widget>[
                //             ElevatedButton(
                //               child: Text("ok"),
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //             )
                //           ],
                //         ));

                setState(() {
                  foods.removeRange(0, foods.length - 1);
                });
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget itemList(List<Food> _list) {
    if (_list.length > 0) {
      return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          String foodName = _list[index].getFoodName();
          int price = _list[index].getPrice();
          int quantity = _list[index].getQuantity();
          String tempName = "";
          if (foodName.length > 30) {
            tempName = foodName.substring(0, 15);
            tempName = tempName + "...";
          } else {
            tempName = foodName;
          }
          return Container(
            decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      tempName,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 0) {
                            quantity--;
                            _list[index].setQuantity(quantity);
                            setState(() {
                              this.foods = _list;
                            });
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          quantity++;
                          _list[index].setQuantity(quantity);
                          setState(() {
                            this.foods = _list;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: () {
                          _list.removeAt(index);
                          setState(() {
                            this.foods = _list;
                          });

                          print(_list.asMap());
                        },
                        icon: Icon(Icons.link_off_rounded),
                        color: Colors.red,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    return Center(
      child: Text(
        'Empty',
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
