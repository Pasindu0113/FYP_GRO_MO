import 'dart:ffi';

class Herb{
  String? name;
  String? description;
  List<String>? soilTypes;
  String? imageReference;

  Herb({
    this.name,
    this.description,
    this.soilTypes,
    this.imageReference
});

  static Herb fromJson(Map<String, dynamic> json) {
    return Herb(
      name: json["name"],
      description: json["description"],
      soilTypes: json["soilTypes"],
      imageReference: json["image"]
    );
  }

}