import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Soil {
  String? name;
  String? description;
  List<dynamic>? crops;
  String? imageReference;

  Soil({required this.name, required this.description, required this.crops, required this.imageReference});

  static Soil fromJson(Map<String, dynamic> json) {
    return Soil(
        imageReference: json["imageReference"],
        name: json["name"],
        crops: json["crops"],
        description: json["description"]);
  }
}
