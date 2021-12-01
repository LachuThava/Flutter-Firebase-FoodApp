import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/LoginPage.dart';

class user extends StatefulWidget {
  const user({Key? key}) : super(key: key);

  @override
  _userState createState() => _userState();
}

void signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => LoginPage()));
}

class _userState extends State<user> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: height,
          // color: Colors.white70,
          // color: Colors.brown[200],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.3,
                  width: width * 0.9,
                  // color: Colors.amberAccent,
                  margin: EdgeInsets.fromLTRB(100, 100, 100, 40),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn.dribbble.com/users/258358/screenshots/3306125/media/1bb9e2c67e4ad49f8e2cee994da6f6f1.png?compress=1&resize=800x600"),
                    backgroundColor: Colors.black54,
                    minRadius: 30,
                    maxRadius: 50,
                  ),
                ),
                Material(
                  elevation: 2,
                  child: Container(
                    width: width * 0.9,
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    padding: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          createTiles(
                              context,
                              "Email : ",
                              FirebaseAuth.instance.currentUser!.email
                                  .toString()),
                          createTiles(context, "Change Password ", ""),
                          createTiles(context, "Payments", ""),
                          createTiles(context, "Your cart", ""),
                          Container(
                            width: width * 0.2,
                            margin: EdgeInsets.all(30),
                            child: ElevatedButton(
                              onPressed: () {
                                signOut(context);
                              },
                              child: Text(
                                'Logout',
                                style: TextStyle(fontSize: 20),
                              ),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createTiles(
    BuildContext context,
    String text,
    String t1,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
        child: ListTile(
            enabled: true,
            minLeadingWidth: MediaQuery.of(context).size.width,
            title: Text(
              text + t1,
              style: TextStyle(fontSize: 20),
            ),
            tileColor: Colors.grey[100]),
      ),
    );
  }
}
