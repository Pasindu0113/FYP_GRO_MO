import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class ScannedSoil {
  String? soilType;
  String? userReference;
  String? imageReference;

  ScannedSoil({required this.soilType, required this.userReference, required this.imageReference});

  static ScannedSoil fromJson(Map<String, dynamic> json) {
    return ScannedSoil(
        imageReference: json["imageReference"],
        soilType: json["soilType"],
        userReference: json["userReference"]
    );
  }
}
