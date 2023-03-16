//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gro_mo/screens/resetPassword_screen.dart';
import 'package:gro_mo/screens/signup_screen.dart';
import 'package:gro_mo/screens/start_screen.dart';

import '../reusable_widgets/resuable_widget.dart';
import 'home_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.white,
                  child : const Text(
                    "Log in",
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Enter Username", Icons.person_outline, false,
                  _userNameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              forgotPassword(context),
              const SizedBox(
                height: 20,
              ),
              reusableButton(context, "LOG IN", () {
                FirebaseAuth.instance.signInWithEmailAndPassword(email: _userNameTextController.text, password: _passwordTextController.text).then((value) async {
                  final User? user = FirebaseAuth.instance.currentUser;
                  final userID = user?.uid;
                  DatabaseReference referenceForName =
                  FirebaseDatabase.instance.ref("Users/$userID/userName");
                  DatabaseEvent eventForName = await referenceForName.once();
                  StartScreen.nameOfCurrentUser = eventForName.snapshot.value.toString();

                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                }).catchError((onError){
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("Invalid Username or Password"),
                      actions: [
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, child: Text("Ok"))
                      ],
                    );
                  });
                });
              }, MediaQuery.of(context).size.width, 50, Color(0xFF101D24)),
            ]),
          ),
        ),
      ),
    );
  }

  Widget forgotPassword(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomLeft,
      child: TextButton(
        child: const Text("Forgot Password?",
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
          textAlign: TextAlign.left,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
        },
      ),
    );
  }
}
