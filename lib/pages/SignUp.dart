import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/LoginPage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

final _formKey = GlobalKey<FormState>();
final _auth = FirebaseAuth.instance;
String _email = '';
String _password = '';
String _address = '';
String _cardNo = '';

void signup(BuildContext context) async {
  await _auth
      .createUserWithEmailAndPassword(email: _email, password: _password)
      .catchError((onError) {
    print(onError);
  }).then((authuser) {
    if (authuser.user != null) {
      addFireStore(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    }
  });
}

Future<void> addFireStore(BuildContext context) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  users.doc(FirebaseAuth.instance.currentUser!.uid).set({
    'email': _email,
    'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
    'address': _address,
    'CardNo': _cardNo
  });
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Image(
                image: AssetImage('assets/Signup.png'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                left: 30,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              Positioned(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white54,
                      ),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              padding: EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      style: TextStyle(fontSize: 30),
                                      onChanged: (value) {
                                        setState(() {
                                          _email = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle: TextStyle(fontSize: 25)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Email Address";
                                        } else if (!RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
                                          return "Email Address format is wrong";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(height: 50),
                                    TextFormField(
                                      style: TextStyle(fontSize: 30),
                                      onChanged: (value) {
                                        setState(() {
                                          _password = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle: TextStyle(fontSize: 25)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "enter password";
                                        } else if (value.length < 8) {
                                          return "Password is minimum 8 letters";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 30),
                                      onChanged: (value) {
                                        setState(() {
                                          _address = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'address',
                                          labelStyle: TextStyle(fontSize: 25)),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return "Enter Email Address";
                                      //   } else if (!RegExp(
                                      //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      //       .hasMatch(value)) {
                                      //     return "Email Address format is wrong";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 30),
                                      onChanged: (value) {
                                        setState(() {
                                          _cardNo = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Debit/Credit Card',
                                        labelStyle: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    SizedBox(height: 60),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            signup(context);
                                            print("clicked");
                                          }
                                        },
                                        child: Text(
                                          'Create',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
