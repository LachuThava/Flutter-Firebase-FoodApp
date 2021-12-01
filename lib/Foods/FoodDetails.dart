import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:collection';

void signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pop();
}

//variables declare
int i = 0;
List _list = [];

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                alignment: Alignment.centerRight,
              ),
            ),
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
                  height: h * 0.4,
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
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Price: Rs. " + widget.price + "/=",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Rating : " + widget.rating + "/5",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Container(
                // color: Colors.brown,
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
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
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                decoration: BoxDecoration(),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      retrieveData(context, i, widget.name, widget.price);

                      Navigator.of(context).pop();
                      setState(() {
                        i = 0;
                      });
                    },
                    child: Text(
                      'AddCart',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }

  retrieveData(BuildContext context, int i, String name, String price) async {
    var snap = await FirebaseFirestore.instance
        .collection('Payments')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get(const GetOptions(source: Source.cache));

    print("datassssssss");
    print(snap.data()!['0']);
    _list = snap.data()!['0'];
    addToCart(context, i, name, price);
  }

  addToCart(BuildContext context, int i, String name, String price) async {
    bool check = false;
    bool emptycheck = false;
    int index = 0;
    if (_list.isEmpty) {
      emptycheck = true;
      _list.add({'name': name, 'price': price, 'count': i});
    }
    if (emptycheck == false) {
      for (int j = 0; j < _list.length; j++) {
        if (_list[j]['name'] == name) {
          index = j;
          check = true;
          break;
        }
      }
      print(_list);
      // print("index");
      // print(index);
      // print("check");
      // print(check);
      emptycheck = false;
      if (check) {
        print(_list[index]);
        _list[index].update('count', (value) => value + i);
      }
      if (!check) {
        _list.add({'name': name, 'price': price, 'count': i});
      }
      check = false;
      print("::::");
      print(_list);

      var snap = await FirebaseFirestore.instance
          .collection("Payments")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(const GetOptions(source: Source.cache));

      if (snap.data()!['0'].length == 0) {
        FirebaseFirestore.instance
            .collection("Payments")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({"0": _list});
      } else {
        FirebaseFirestore.instance
            .collection("Payments")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({"0": _list});
      }
      // for (int k = 0; k < _list.length; k++) {
      // await FirebaseFirestore.instance
      //     .collection("Payments")
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .update({
      //   "0": [_list]
      // });
    }

    // for (int k = 0; k < _list.length; k++) {
    await FirebaseFirestore.instance
        .collection("Payments")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({"0": _list});
    // }
  }
}
