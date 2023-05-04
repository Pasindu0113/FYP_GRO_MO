import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../reusable_widgets/resuable_widget.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _nContentTextController = TextEditingController();
  final TextEditingController _pContentTextController = TextEditingController();
  final TextEditingController _kContentTextController = TextEditingController();
  final TextEditingController _temperatureTextController = TextEditingController();
  final TextEditingController _humidityTextController = TextEditingController();
  final TextEditingController _phLevelTextController = TextEditingController();
  final TextEditingController _rainfallTextController = TextEditingController();
  String? predictedCrop = "";

  predictCrop(String nContent, String pContent, String kContent, String temperature, String humidity, String ph,String rainfall ) async {
    final url = Uri.parse("https://4667-161-74-224-4.ngrok-free.app/crops");
    final headers = {'Content-Type': 'application/json'};

    final data = jsonEncode({
      'N': nContent,
      'P': pContent,
      'K': kContent,
      'temperature': temperature,
      'humidity': humidity,
      'ph': ph,
      'rainfall': rainfall
    });


    final response = await http.post(url, headers: headers, body: data);

    if (response.statusCode == 200) {
      final resJson = jsonDecode(response.body);
      setState(() {
        predictedCrop = resJson['predicted_crop'];
        print("test${predictedCrop!}");
        print("test${resJson['predicted_crop']}");
      });
    } else {
      throw Exception('Failed to retrieve predicted crop from server');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.white,
                  child: const Text(
                    "Crop Prediction",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.white,
                    child: TextField(
                      controller: _nContentTextController,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                      decoration: InputDecoration(
                        labelText: "Nitrogen Content",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.name,
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.white,
                    child: TextField(
                      controller: _pContentTextController,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                      decoration: InputDecoration(
                        labelText: "Phosphorus Content",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.name,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.white,
                    child: TextField(
                      controller: _kContentTextController,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                      decoration: InputDecoration(
                        labelText: "Potassium Content",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.name,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.white,
                    child: TextField(
                      controller: _temperatureTextController,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                      decoration: InputDecoration(
                        labelText: "Temperature",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.name,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.white,
                    child: TextField(
                      controller: _humidityTextController,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                      decoration: InputDecoration(
                        labelText: "Humidity",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.name,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.white,
                    child: TextField(
                      controller: _phLevelTextController,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                      decoration: InputDecoration(
                        labelText: "PH Level",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.name,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.white,
                    child: TextField(
                      controller: _rainfallTextController,
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                      decoration: InputDecoration(
                        labelText: "Rainfall",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.name,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              reusableButton(context, "Predict Crop", () async {
                if (_nContentTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please provide a nitrogen content',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                        ),
                      )));
                  return;
                }
                if (_pContentTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please provide a phosphorus content',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                        ),
                      )));
                  return;
                }
                if (_pContentTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please provide a potassium content',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                        ),
                      )));
                  return;
                }
                if (_temperatureTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please provide a temperature',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                        ),
                      )));
                  return;
                }
                if (_humidityTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please provide a humidity',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                        ),
                      )));
                  return;
                }
                if (_phLevelTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please provide a ph level',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                        ),
                      )));
                  return;
                }
                if (_rainfallTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Please provide a rainfall',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                        ),
                      )));
                  return;
                }
                await predictCrop(_nContentTextController.text, _pContentTextController.text, _kContentTextController.text, _temperatureTextController.text, _humidityTextController.text, _phLevelTextController.text, _rainfallTextController.text);
                print("outside$predictedCrop");
              }, MediaQuery.of(context).size.width, 50, Color(0xFF101D24)),
              const SizedBox(
                height: 20,
              ),
              predictedCrop == ""
                  ? Text("") : Text("Predicted Crop is $predictedCrop",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: Colors.black),
                textAlign: TextAlign.left,),
              const SizedBox(
                height: 30,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
