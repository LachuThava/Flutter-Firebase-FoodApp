import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/pages/Products.dart';

class ProductsVM with ChangeNotifier {
  List<Products> lst = <Products>[];

  ProductsVM(String name, String price, String count);

  add(String price, String name, String count) {
    lst.add(Products(price: price, name: name, count: count));
    notifyListeners();
  }

  del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }

  searchName(String name, int count, String price) {
    bool check = false;
    lst.forEach((element) {
      if (element.name == name) {
        check = true;
      }
    });
    if (check == true) {
      lst.forEach((element) {
        if (element.name == name) {
          int temp = int.parse(element.count);
          temp += count;
          element.count = temp.toString();
        }
      });
    }
  }

  List printList() {
    notifyListeners();
    // TODO: implement toString
    return lst;
  }

  ItemList(BuildContext context) {
    return ListView.builder(
      itemCount: lst.length,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Text(lst[index].name),
              SizedBox(width: 30),
              IconButton(onPressed: () {}, icon: Icon(Icons.minimize)),
              Text(lst[index].count),
              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ],
          ),
        );
      },
    );
  }
}
