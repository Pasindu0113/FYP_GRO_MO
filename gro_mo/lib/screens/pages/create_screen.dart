//import 'dart:html';
import 'dart:convert';
import 'dart:io';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../reusable_widgets/resuable_widget.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  File? selectedImage;
  String? soilType = "";

  getSoilType() async {
    final request = http.MultipartRequest("POST",Uri.parse("https://b998-161-74-230-5.ngrok-free.app/predict"));
    final headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile('image',
      selectedImage !.readAsBytes().asStream(), selectedImage !.lengthSync(),
      filename: selectedImage !.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson =  jsonDecode(res.body);
    soilType = resJson['soil_type'];
    setState(() {});
  }

  Future getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              Container(
                color: Colors.white,
                child: const Text(
                  "Soil Classification",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              selectedImage == null 
                  ? Text("Please pick an Image to Upload")
                  : Image.file(selectedImage!),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(onPressed: getImage, icon: Icon(Icons.upload_file), label: selectedImage == null
                  ? Text("Upload Image")
                  : Text("Change Image")),
              const SizedBox(
                height: 20,
              ),
              if(selectedImage != null)
                reusableButton(context, "Predict Soil Type", () {
                  getSoilType();
                }, MediaQuery.of(context).size.width, 50, Color(0xFF101D24)),
              const SizedBox(
                height: 20,
              ),
              soilType == ""
                ? Text("") : Text("Soil Type is $soilType")
            ]),
          ),
        ),
      ),
    );
  }

//   Future pickImage() async {
//     final ImagePicker _picker = ImagePicker();
// // Pick an image
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// //TO convert Xfile into file
//     File file = File(image!.path);
// //print(‘Image picked’);
//     return file;
//
//     // XFile? pickedFile =
//     // await imagePicker.pickImage(source: ImageSource.gallery);
//     // print('This file path ${file?.path}');
//     //
//     // if (file == null) return;
//     // //final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
//     //
//     // setState(() {
//     //   file = pickedFile;
//     //   print('This file path ${pickedFile?.path}');
//     // });
//   }
}
