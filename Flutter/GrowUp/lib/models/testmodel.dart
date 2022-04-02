// To parse this JSON data, do
//
//     final testModel = testModelFromJson(jsonString);

import 'dart:convert';

List<TestModel> testModelFromJson(String str) =>
    List<TestModel>.from(json.decode(str).map((x) => TestModel.fromJson(x)));

String testModelToJson(List<TestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestModel {
  TestModel({
    this.id,
    this.question,
    this.examId,
    this.exam,
    this.options,
  });

  int? id;
  String? question;
  int? examId;
  dynamic exam;
  List<dynamic>? options;

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        id: json["id"],
        question: json["question"],
        examId: json["examID"],
        exam: json["exam"],
        options: List<dynamic>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "examID": examId,
        "exam": exam,
        "options": List<dynamic>.from(options!.map((x) => x)),
      };
}
