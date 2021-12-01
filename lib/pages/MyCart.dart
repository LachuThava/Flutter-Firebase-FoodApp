import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_app/Foods/FoodDetails.dart';
import 'package:my_app/pages/ProductsVM.dart';
import 'package:provider/provider.dart';

// var snap = FirebaseFirestore.instance
//     .collection("Payments")
//     .doc(FirebaseAuth.instance.currentUser!.uid)
//     .get(const GetOptions(source: Source.cache));
List _list = [];
int j = 0;

FirestoreChange(BuildContext context, List _list) async =>
    await FirebaseFirestore.instance
        .collection("Payments")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({0.toString(): _list});

retrieveList(BuildContext context, _list) async {
  var snap = await FirebaseFirestore.instance
      .collection('Payments')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get(const GetOptions(source: Source.cache));

  print("datassssssss");
  // print(snap.data()!['0']);
  _list = snap.data()!['0'];
  print(_list);
}

class mycard extends StatefulWidget {
  const mycard({Key? key}) : super(key: key);

  @override
  _mycardState createState() => _mycardState();
}

class _mycardState extends State<mycard> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              image: NetworkImage(
                "https://cdn.dribbble.com/users/2046015/screenshots/5973727/media/a603779536f0491b4be24ba2d03903e1.gif",
              ),
              fit: BoxFit.cover,
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.5,
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
              height: h * 0.5,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: itemList(context),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: h * 0.1,
              child: Container(
                width: w,
                height: h * 0.1,
                decoration: BoxDecoration(),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text(
                    'PayNow',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemList(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Payments')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          _list = snapshot.data!['0'];
          var snap = snapshot.data;
          if (_list.length == 0) {
            return new Center(
                child: Text(
              'Empty',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ));
          }
          print(snapshot.hasData);
          print("LIST::::");
          print(_list);
          print(_list.length);
          print(_list[0]['name']);
          return new ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              int j = _list[index]['count'];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      // padding: EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        _list[index]['name'],
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (j > 0) {
                              j--;
                            }
                            _list[index].update(('count'), (value) => j);
                            setState(() {
                              FirebaseFirestore.instance
                                  .collection('Payments')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({"0": _list});
                            });
                            print(_list[index]);
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text(
                          j.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            j++;
                            _list[index].update(('count'), (value) => j);
                            setState(() {
                              FirebaseFirestore.instance
                                  .collection('Payments')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({"0": _list});
                            });

                            print(_list[index]);
                          },
                          icon: Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () {
                            _list.removeAt(index);
                            FirebaseFirestore.instance
                                .collection('Payments')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({"0": _list});
                          },
                          icon: Icon(Icons.link_off_rounded),
                          color: Colors.red,
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          );
        });
  }
}
