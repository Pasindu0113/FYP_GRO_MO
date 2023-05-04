import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gro_mo/classes/ScannedSoil.dart';

import '../../reusable_widgets/resuable_widget.dart';

class SoilListScreen extends StatefulWidget {
  const SoilListScreen({Key? key}) : super(key: key);

  @override
  State<SoilListScreen> createState() => _SoilListScreenState();
}

class _SoilListScreenState extends State<SoilListScreen> {
  Stream<List<ScannedSoil>> getScannedSoil() {
    final User? user = FirebaseAuth.instance.currentUser;
    final userID = user?.uid;
    var data = FirebaseFirestore.instance.collection("ClassifiedSoil").where("userReference", isEqualTo: userID).snapshots().map(
            (snapshot) =>
            snapshot.docs.map((doc) => ScannedSoil.fromJson(doc.data())).toList());
    print("This is the stream : ${data.toList().toString()}");
    return data;
  }

  Future<Uint8List?> loadImage(String url) async {
    final Reference ref = FirebaseStorage.instance.ref().child("scannedImages").child(url);
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

  Widget buildScannedImages(ScannedSoil scannedSoil) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5, color: Colors.grey),
          ),
        ),
        child: ListTile(
          leading: ClipOval(
            child: SizedBox.fromSize(
                size: Size.fromRadius(30), // Image radius
                child: returnImage(context, scannedSoil.imageReference!)),
          ),
          title: Text(
            scannedSoil.soilType!,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.more_vert_outlined),
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
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.width * 0.6,
                              child: returnImage(context, scannedSoil.imageReference!),
                            ),
                          ),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Text(
                                  "Predicted Soil Type",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  textAlign: TextAlign.left,
                                ),
                              )),
                          Center(
                            child: Text(
                              scannedSoil.soilType!.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          reusableButton(context, "Delete", () async {
                            String? imageReference = scannedSoil.imageReference;
                            final collectionReference = FirebaseFirestore.instance.collection('ClassifiedSoil');
                            final QuerySnapshot querySnapshot = await collectionReference.where('imageReference', isEqualTo: imageReference).get();
                            final String documentId = querySnapshot.docs[0].id;
                            await collectionReference.doc(documentId).delete().then((value) async {
                              final Reference ref = FirebaseStorage.instance.ref().child("scannedImages").child(imageReference!);
                              await ref.delete();
                              Navigator.of(context).pop();
                            }).catchError((err) {
                              print(err);
                            });
                          }, MediaQuery.of(context).size.width, 50, Colors.redAccent),
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
                  "My Classified Images",
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
                child: StreamBuilder<List<ScannedSoil>>(
                  stream: getScannedSoil(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("");
                    } else if (snapshot.hasData) {
                      final scannedImages = snapshot.data!;
                      return ListView(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        children: scannedImages.map(buildScannedImages).toList(),
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
