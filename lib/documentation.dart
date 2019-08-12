// To parse this JSON data, do
//
//     final documentation = documentationFromJson(jsonString);

import 'dart:convert';

Documentation documentationFromJson(String str) =>
    Documentation.fromJson(json.decode(str));

String documentationToJson(Documentation data) => json.encode(data.toJson());

class Documentation {
  String name;
  String category;
  List<String> syntax;
  String description;
  List<String> examples;
  List<String> seealso;
  String mathjs;

  Documentation({
    this.name,
    this.category,
    this.syntax,
    this.description,
    this.examples,
    this.seealso,
    this.mathjs,
  });

  factory Documentation.fromJson(Map<String, dynamic> json) =>
      new Documentation(
        name: json["name"],
        category: json["category"],
        syntax: new List<String>.from(json["syntax"].map((x) => x)),
        description: json["description"],
        examples: new List<String>.from(json["examples"].map((x) => x)),
        seealso: new List<String>.from(json["seealso"].map((x) => x)),
        mathjs: json["mathjs"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "syntax": new List<dynamic>.from(syntax.map((x) => x)),
        "description": description,
        "examples": new List<dynamic>.from(examples.map((x) => x)),
        "seealso": new List<dynamic>.from(seealso.map((x) => x)),
        "mathjs": mathjs,
      };
}
