import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/SignUp.dart';
import 'package:my_app/Components/BottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

String _email = '';
String _password = '';
List<Map> _list = [];

void SignIn(BuildContext context) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: _email, password: _password)
      .catchError((onError) {
    print(onError);
  }).then((authUser) {
    if (authUser.user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BottomNavBar()));
    }
  });

  await FirebaseFirestore.instance
      .collection("Payments")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({"0": []});
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(color: Colors.white),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Ahaa_Biriyani_logo.jpg"),
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(35),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                              fontSize: 30,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _email = value.trim();
                              });
                            },
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.email),
                              // hintText: 'Email Address',
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 30),
                              // hintStyle: TextStyle(
                              //   fontSize: 20,
                              // ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Correct Email Address";
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Email Address format is wrong";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _password = value.trim();
                              });
                            },
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                            decoration: InputDecoration(
                              // hintText: 'Password',
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 30),
                              hintStyle: TextStyle(
                                fontSize: 50,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(30),
                              // ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "required";
                              } else if (value.length < 8) {
                                return "Password is minimum 8 letters";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                SignIn(context);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.2, 0.8),
                                  )
                                ],
                              ),
                              child: Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'you dont have account ? ',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp()));
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(
                            image: AssetImage('assets/google_icon.png'),
                            // width: 100,
                            // height: 100,
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image(
                            image: AssetImage("assets/fb.jpg"),
                            // width: 50,
                            // height: 50
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
