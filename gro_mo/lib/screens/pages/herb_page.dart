import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HerbPage extends StatefulWidget {
  const HerbPage({Key? key}) : super(key: key);

  @override
  State<HerbPage> createState() => _HerbPageState();
}

class _HerbPageState extends State<HerbPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Text("Herb Page"),
    );
  }
}
