import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/resuable_widget.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
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
                    "Register",
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
              reusableTextField("Enter Email", Icons.person_outline, false,
                  _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              signInSignUpButton(context, false, () {
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text).then((value) {
                  print("Created New Account");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                }).catchError((err){
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text(err.toString()),
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
}
