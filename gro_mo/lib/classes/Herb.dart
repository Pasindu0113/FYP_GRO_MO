import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Herb {
  String? name;
  String? description;
  List<dynamic>? soilTypes;
  String? imageReference;

  Herb({required this.name, required this.description, required this.soilTypes, required this.imageReference});

  static Herb fromJson(Map<String, dynamic> json) {
    return Herb(
        imageReference: json["image"],
        name: json["name"],
        soilTypes: json["soilTypes"],
        description: json["description"]);
  }
}
