import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../classes/Soil.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  Stream<List<Soil>> getSoil() {
    var data = FirebaseFirestore.instance.collection("Soil").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Soil.fromJson(doc.data())).toList());
    return data;
  }

  Future<Uint8List?> loadImage(String url) async {
    final Reference ref = FirebaseStorage.instance.ref().child(url);
    const int maxSize = 10 * 1024 * 1024;
    final Uint8List? imageData = await ref.getData(maxSize);
    return imageData;
  }

  Widget returnImage(BuildContext context, String imageUrl) {
    return FutureBuilder<Uint8List?>(
      future: loadImage(imageUrl),
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildSoil(Soil soil) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5, color: Colors.grey),
          ),
        ),
        child: ListTile(
          leading: ClipOval(
            child: SizedBox.fromSize(
                size: Size.fromRadius(30), // Image radius
                child: returnImage(context, soil.imageReference!)),
          ),
          title: Text(
            soil.name!,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.more_vert_outlined),
          onTap: () {
            showGeneralDialog(
              barrierDismissible: false,
              transitionDuration: const Duration(milliseconds: 200),
              context: context,
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondAnimation) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  scrollable: true,
                  content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: IconButton(
                                icon: const Icon(Icons.close_outlined),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ),
                          Center(
                            child: Text(
                              soil.name!.toString(),
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
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.width * 0.6,
                              child: returnImage(context, soil.imageReference!),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Text(
                                  soil.description!.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      color: Colors.black),
                                  textAlign: TextAlign.left,
                                ),
                              )),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Text(
                                  "Crop Suggestion",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  textAlign: TextAlign.left,
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ListView.builder(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                shrinkWrap: true,
                                itemCount: soil.crops?.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                    dense: true,
                                    title: Text(
                                      soil.crops?[index],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  );
                                }),
                          ),
                        ]),
                      )),
                );
              },
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.08, 20, 0),
          child: Column(children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                color: Colors.white,
                child: const Text(
                  "Discover",
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
              height: 20,
            ),
            Expanded(
                child: StreamBuilder<List<Soil>>(
              stream: getSoil(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("");
                } else if (snapshot.hasData) {
                  final soil = snapshot.data!;
                  return ListView(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    children: soil.map(buildSoil).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )),
          ]),
        ),
      ),
    );
  }
}
