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
    this.name,
    this.gender,
    this.age,
    this.designation,
    this.salary,
  });

  int? id;
  String? name;
  String? gender;
  int? age;
  String? designation;
  int? salary;

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        designation: json["designation"],
        salary: json["salary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "age": age,
        "designation": designation,
        "salary": salary,
      };
}
