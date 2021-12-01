import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'FoodDetails.dart';

class lunchFoods extends StatefulWidget {
  const lunchFoods({Key? key}) : super(key: key);

  @override
  _lunchFoodsState createState() => _lunchFoodsState();
}

class _lunchFoodsState extends State<lunchFoods> {
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
            .doc('Lunch')
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
}
