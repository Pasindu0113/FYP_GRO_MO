import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../start_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Logout"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StartScreen()));
          },
        ),
      ),
    );
  }
}
