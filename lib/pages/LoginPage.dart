import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_app/pages/SignUp.dart';
import 'package:my_app/Components/BottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

void SignIn(String email, String password, BuildContext context) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .catchError((onError) {
    print(onError);
  }).then((authUser) {
    if (authUser.user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BottomNavBar()));
    }
  });
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _obScure = true;
  bool darkMode = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController
        .dispose(); // Dispose the controllers when they're no longer needed
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void googleSignIn() {}
    void fbSignIn() {}

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  width: size.width,
                  height: 100,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                      },
                      icon: Icon(
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        size: 40,
                      ),
                    ),
                  )),
              Image.asset(
                "assets/Ahaa_Biriyani_logo.png",
                height: size.height * 0.4,
                width: size.width,
                fit: BoxFit.fill,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 255, 255, 255),
                          ),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(20),
                        child: TextField(
                          controller: emailController,
                          style: TextStyle(
                            fontSize: 30,
                            color: MyApp.themeNotifier.value == ThemeMode.light
                                ? Colors.black54
                                : Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "Example@gmail.com",
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                              gapPadding: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 255, 255, 255),
                          ),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(20),
                        child: TextField(
                          obscureText: _obScure,
                          controller: passwordController,
                          style: TextStyle(
                            fontSize: 30,
                            color: MyApp.themeNotifier.value == ThemeMode.light
                                ? Colors.black54
                                : Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _obScure ? Icons.lock : Icons.lock_open),
                                onPressed: () {
                                  setState(() {
                                    _obScure = !_obScure;
                                  });
                                }),
                            hintText: "password",
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                              gapPadding: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(

                          // color: Color.fromARGB(255, 255, 255, 255),
                          ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            textStyle: TextStyle(
                              fontSize: 30,
                            ),
                            primary: Colors.indigo),
                        onPressed: () {
                          SignIn(emailController.text.trim(),
                              passwordController.text.trim(), context);
                        },
                        child: Text("Sign In"),
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 255, 255, 255),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "You don't have an Account.....",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUp()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 255, 255, 255),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Image(
                                image: AssetImage('assets/google_icon.png'),
                                // width: 100,
                                // height: 100,
                              ),
                            ),
                            onTap: () {
                              print("pressed");
                              googleSignIn();
                            },
                          ),
                          SizedBox(width: 20),
                          InkWell(
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image: AssetImage("assets/fb.jpg"),
                                ),
                              ),
                              onTap: () => {fbSignIn()}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  // color: Color.fromARGB(255, 255, 255, 255),
                  width: size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
