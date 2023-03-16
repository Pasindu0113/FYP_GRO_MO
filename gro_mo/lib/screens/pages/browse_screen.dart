import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gro_mo/reusable_widgets/resuable_widget.dart';
import 'package:gro_mo/screens/pages/herb_page.dart';

import '../../classes/Herb.dart';
import '../start_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String test1 = "test1";
  String test2 = "test2";
  String test3 = "test3";
  String test4 = "test4";
  String test5 = "test5";

  Stream<List<Herb>> getHerbs() {
      var data = FirebaseFirestore.instance
          .collection("Herbs")
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Herb.fromJson(doc.data())).toList());
      print("data issssss ${data.toList()}");
      return data;
  }

  Widget buildHerbs(Herb herb) => ListTile(
    title: Text(herb.name!),
    subtitle: Text(herb.description!),
  );

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
              reusableButton(context, "Tap", (){
                var db = FirebaseFirestore.instance;
                final docRef = db.collection("Herbs").doc("Z2gtuOMvjQj0g9bzBjeQ");
                docRef.get().then(
                        (DocumentSnapshot doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      test1 = data.toString();
                      print(data.toString());
                    },
                    onError: (e) => print("Error getting document: $e"));

              }, MediaQuery.of(context).size.width, 50, Color(0xFF101D24)),
              const SizedBox(
                height: 20,
              ),
              Text(test1)
              // StreamBuilder<List<Herb>>(
              //   stream: getHerbs(),
              //   builder: (context, snapshot) {
              //     if(snapshot.hasError){
              //       return Text("Error");
              //     }else if(snapshot.hasData){
              //       final herbs = snapshot.data!;
              //       return ListView(
              //         children: herbs.map(buildHerbs).toList(),
              //       );
              //     }else{
              //       return Center(child: CircularProgressIndicator());
              //     }
              //   },
              // )
              // ListView.builder(
              //     padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              //   itemCount: 1,
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //     return Column(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) =>
              //                         HerbPage()));
              //           },
              //           child: const Align(
              //             alignment: Alignment.centerLeft,
              //             child: Card(
              //               child: ListTile(
              //                 trailing: Icon(Icons.arrow_forward_ios),
              //                 title: Text(
              //                   "Sign Out",
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontFamily: 'Roboto',
              //                       fontSize: 18),
              //                   textAlign: TextAlign.left,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     );
              //   },
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}
