import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Foods/FoodDetails.dart';

Map<String, dynamic> _mapSelectItem = {};
//  MyCartApi my = new MyCartApi(_mapSelectedItem);

class Desserts extends StatefulWidget {
  const Desserts({Key? key}) : super(key: key);

  @override
  _DessertsState createState() => _DessertsState();
}

class _DessertsState extends State<Desserts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildCard(context),
    );
  }

  Widget BuildCard(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Foods')
            .doc('Desserts')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          Map _map = snapshot.data.data();

          List<Map> _list = [];
          for (var v in _map.values) {
            // print(v);
            _list.add(v);
          }
          // print(_list);
          print('length');
          print(_list.length);
          // print(_list[0]['price']);
          return ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return foodCard(context, index, _list);
              });
          // print(snapshot.data.data());
        });
  }

  foodCard(BuildContext context, int index, List _list) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => new foodDetails(
                  _list[index]['image'],
                  _list[index]['name'],
                  _list[index]['rating'],
                  _list[index]['price'],
                )));
      },
      child: Card(
        child: Container(
          // margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                _list[index]['image'],
              ),
            ),
          ),
          child: Center(
            child: Text(
              _list[index]['name'],
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  // void Selection(String name) {
  //   _mapSelectItem.update(
  //     name,
  //     (value) => ++value,
  //     ifAbsent: () => 1,
  //   );
  //   print(_mapSelectItem);
  //   sendToFirestore(_mapSelectItem, context);
  // }

  // Future<void> sendToFirestore(
  //     Map<String, dynamic> _map, BuildContext context) async {
  //   Map<String, dynamic> _payMap = {};
  //   _payMap = {
  //     DateFormat("MMM, EEE, yyyy HH:mm:ss").format(DateTime.now()): _map,
  //   };
  //   String time =
  //       DateFormat("MMM, EEE, yyyy HH:mm:ss").format(DateTime.now()).toString();
  //   print(time);
  //   DocumentReference payment = FirebaseFirestore.instance
  //       .collection("Payments")
  //       .doc(FirebaseAuth.instance.currentUser!.uid);

  //   payment.set(_payMap);
  // }
}
