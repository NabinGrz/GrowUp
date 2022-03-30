// To parse this JSON data, do
//
//     final practice = practiceFromJson(jsonString);

import 'dart:convert';

List<Practice> practiceFromJson(String str) =>
    List<Practice>.from(json.decode(str).map((x) => Practice.fromJson(x)));

String practiceToJson(List<Practice> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Practice {
  Practice({
    this.id,
    this.skillId,
    this.skill,
    this.text,
    this.options,
  });

  int? id;
  int? skillId;
  dynamic? skill;
  String? text;
  List<Option>? options;

  factory Practice.fromJson(Map<String, dynamic> json) => Practice(
        id: json["id"],
        skillId: json["skillId"],
        skill: json["skill"],
        text: json["text"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skillId": skillId,
        "skill": skill,
        "text": text,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.id,
    this.text,
    this.questionId,
    this.isCorrectOption,
  });

  int? id;
  String? text;
  int? questionId;
  bool? isCorrectOption;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        text: json["text"],
        questionId: json["questionId"],
        isCorrectOption: json["isCorrectOption"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "questionId": questionId,
        "isCorrectOption": isCorrectOption,
      };
}
