import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/pages/LoginPage.dart';
import 'package:my_app/pages/MenuItems.dart';
import 'package:my_app/pages/MyCart.dart';
import 'package:my_app/pages/User.dart';

// Map<String, int> _map = {};

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

int index = 0;
final tabs = [menuItems(), mycard(), user()];
final _auth = FirebaseAuth.instance;

void signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => LoginPage()));
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: tabs[index],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.houseUser),
              title: Text('Biriyani'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('my cart'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Account'),
            ),
          ],
          onTap: (current_index) {
            setState(() {
              index = current_index;
            });
          },
        ),
      ),
    );
  }
}
