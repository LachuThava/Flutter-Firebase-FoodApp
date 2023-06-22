import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/main.dart';
import 'package:my_app/pages/MyCart.dart';
import 'package:my_app/pages/RenderMenuItems.dart';
import 'LoginPage.dart';

void signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => LoginPage()));
}

class menuItems extends StatefulWidget {
  const menuItems({Key? key}) : super(key: key);

  @override
  _menuItemsState createState() => _menuItemsState();
}

final _auth = FirebaseAuth.instance;

Map<String, dynamic> _map = {};

class _menuItemsState extends State<menuItems> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(180.0),
            child: AppBar(
              toolbarHeight: 120,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white70,
              title: Text(
                'Menu',
                style: TextStyle(fontSize: 100, color: Colors.blueGrey),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    signOut(context);
                  },
                  icon: Icon(Icons.logout),
                  color: Colors.black54,
                ),
              ],
              bottom: TabBar(
                // isScrollable: true,
                labelColor: Colors.black,
                indicatorColor: Colors.black54,

                tabs: [
                  Tab(
                    child: Text(
                      "BreakFast",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Lunch",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Dinner",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Desserts",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Tab(
                child: RenderMenuItems('Breakfast'),
              ),
              Tab(
                child: RenderMenuItems('Lunch'),
              ),
              Tab(
                child: RenderMenuItems('Dinner'),
              ),
              Tab(
                child: RenderMenuItems('Desserts'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
