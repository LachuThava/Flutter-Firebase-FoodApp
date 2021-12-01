import 'package:flutter/cupertino.dart';
import 'package:my_app/Foods/Food.dart';

class Foods extends ChangeNotifier {
  String name;
  int count;
  Map<String, int> _map = {};

  Foods({required this.name, required this.count});

  addMap(String name, int count) {
    _map.update(name, (value) => count, ifAbsent: () => count);
  }
}
