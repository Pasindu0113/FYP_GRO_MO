import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gro_mo/screens/signin_screen.dart';
import 'package:gro_mo/screens/signup_screen.dart';

import '../reusable_widgets/resuable_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  static String nameOfCurrentUser = '';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Color(0xFF101D24)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.3, 20, 0),
            child: Column(children: <Widget>[
              logoWidget("assets/images/logo.png"),
              const SizedBox(
                height: 220,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusableButton(context, "LOG IN", () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                  }, 170, 50, Color(0xFF2C424F)),
                  const SizedBox(
                    width: 10,
                  ),
                  reusableButton(context, "REGISTER", () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  }, 170, 50, Color(0xFF2C424F)),
                ],),
            ]),
          ),
        ),
      ),
    );
  }
}