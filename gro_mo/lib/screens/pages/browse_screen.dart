import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../classes/Herb.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  Stream<List<Herb>> getHerbs() {
    var data = FirebaseFirestore.instance.collection("Herbs").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Herb.fromJson(doc.data())).toList());
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

  Widget buildHerbs(Herb herb) {
    return ListTileTheme(
        child: ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 4),
        borderRadius: BorderRadius.circular(5),
      ),
      leading: ClipOval(
        child: SizedBox.fromSize(
            size: Size.fromRadius(30), // Image radius
            child: returnImage(context, herb.imageReference!)),
      ),
      title: Text(
        herb.name!,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.more_vert_outlined),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close_outlined),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(herb.name!.toString()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: returnImage(context, herb.imageReference!),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(herb.description!.toString()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(herb.soilTypes!.toString()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(herb.imageReference!.toString()),
                  ),
                ]),
              ),
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
                child: StreamBuilder<List<Herb>>(
              stream: getHerbs(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error");
                } else if (snapshot.hasData) {
                  final herbs = snapshot.data!;
                  return ListView(
                    children: herbs.map(buildHerbs).toList(),
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
